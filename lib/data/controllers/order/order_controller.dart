import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/common/widgets/dialogs/dialoges.dart';
import 'package:ushop_web/data/repositories/authentication/auth_repository.dart';
import 'package:ushop_web/featuers/dashboard/controllers/orders_table_controller.dart';
import 'package:ushop_web/utils/constants/app_images.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';
import 'package:uuid/uuid.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/app_popups.dart';
import '../../models/order/order_model.dart';
import '../../models/user/user_model.dart';
import '../../repositories/order_repository/order_repository.dart';
import '../address/address_controller.dart';
import '../cart/cart_controller.dart';
import '../user/user_controller.dart';

class OrderController extends GetxController {
//*******************************************instance creator***************************************/
  //instance creator
  static OrderController get instance => Get.find();

//******************************************* variabels ***************************************/
  //orders list
  RxList<OrderModel> ordersList = <OrderModel>[].obs;

  //loader
  RxBool loader = false.obs;

  //order repository
  final OrderRepository _orderRepository = Get.put(OrderRepository());

  //current order
  Rx<OrderModel> currentOrder = OrderModel.emptyOrderModel().obs;

  //all users orders
  RxList<OrderModel> allUsersOrders = <OrderModel>[].obs;

  //all users orders classification according to order state
  RxMap<OrderStatus, Map<String, num>> ordersClassification = <OrderStatus, Map<String, num>>{}.obs;

  //initial sorting value
  final RxString initialSortingValue = "id".obs;

//******************************************* overrided ***************************************/
  @override
  void onInit() async {
    // fetchOrders;
    await fetchAllUsersOrders();
    super.onInit();
  }

//******************************************* getters ***************************************/
// get the cllassified order count
  int getClassifiedOrderCount(OrderStatus orderStatus) {
    return ordersClassification[orderStatus]!.length;
  }

// get the total amount order for classified orders
  double getClassifiedOrdersTotalAmount(OrderStatus orderStatus) {
    return double.parse(ordersClassification[orderStatus]!["Total"]!.toStringAsFixed(2));
  }

//******************************************* methods ***************************************/
  //fatch orders
  Future<void> fetchOrders() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }
      //start loading
      loader.value = true;

      //fatch data
      final data = await _orderRepository.fetchOrders();

      //asign allProducts
      ordersList.assignAll(data);

      //stop loading
      loader.value = false;
    } catch (e) {
      //show error message
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loading
      loader.value = false;
    }
  }

  //commit checkout
  //save order
  Future<void> commitSaveOrder() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }
      //start loading
      loader.value = true;

      //save order
      await _saveOrder();

      //stop loading
      loader.value = false;

      //show success masseage
      AppPopups.showSuccessSnackBar(title: "Done Successfully", message: 'your order is done successfully');
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      loader.value = false;
    }
  }

  //save order
  Future<void> _saveOrder() async {
    var uuid = const Uuid();
    String id = uuid.v4();
    String userId = AuthRepository.instance.authUser!.uid;
    UserModel currentUser = UserController.instance.currentUser.value;
    CartController cartController = Get.find();
    // PaymentMethodsController paymentController = Get.find();
    AddressController addressController = Get.find();
    await _orderRepository.saveOrder(
      OrderModel(
        id: id,
        userId: userId,
        orderStatus: OrderStatus.processing,
        userName: currentUser.userName,
        userEmail: currentUser.email,
        items: cartController.cartItemsList,
        orderDate: DateTime.now(),
        deliveryDate: DateTime.now().add(const Duration(days: 15)),
        deliveryAddress: addressController.selectedUserAddress.value,
        // paymentMethod: paymentController.selectedPaymentMethod['name'],
        paymentMethod: "",
        orderTotalAmount: cartController.orderTotalAmount.value,
      ),
    );
    cartController.removeAllCartItems();
    // Get.to(() => const LoadingScreen(loadWidget: Image(image: AssetImage(AppImages.sandWatchLoading))));
  }

  //fetch all users orders
  Future<void> fetchAllUsersOrders() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }
      //start loading
      loader.value = true;

      //save order
      final data = await _orderRepository.fetchAllUsersOrders();

      //assign to allusers data
      allUsersOrders.assignAll(data);

      //classify orders
      await _classifyOrders();

      //stop loading
      loader.value = false;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      loader.value = false;
    }
  }

  //calculate shipping fee price
  double calculateShippingFeePrice(double total) {
    return total * 0.05;
  }

  //calculate tax fee price
  double calculateTaxFeePrice(double total) {
    return total * 0.14;
  }

  //caculate pyment method fee
  double calculatePaymentMethodFee(String paymentMethod, double total) {
    //get fee method
    PaymentMethods? result = HelperFunctions.getPaymentMethodFromString(paymentMethod);

    final feeRate = HelperFunctions.getPaymentFee(result);
    //calculate fee using feeRate
    return ((feeRate * total) / 100);
  }

  //calculate discound
  double calculateDiscount(double total, double subtotal) {
    //totalamount-subtotal-taxfee-shipping
    final double discount = (subtotal + calculateTaxFeePrice(subtotal) + calculateShippingFeePrice(subtotal) - total);
    if (discount < 0) {
      return 0;
    } else {
      return discount;
    }
  }

  //classify orders
  Future<void> _classifyOrders() async {
    for (var order in allUsersOrders) {
      if (ordersClassification.containsKey(order.orderStatus)) {
        ordersClassification[order.orderStatus]!['Orders'] = ordersClassification[order.orderStatus]!['Orders']! + 1;
        ordersClassification[order.orderStatus]!['Total'] = ordersClassification[order.orderStatus]!['Total']! + order.orderTotalAmount;
      } else {
        ordersClassification[order.orderStatus] = {'Orders': 1, 'Total': order.orderTotalAmount};
      }
    }
  }

  //update order status
  Future<void> updateOrderStatus(String userId, String orderId, OrderStatus orderStatus) async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }

      //show loading screen
      Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 120, height: 120));

      //update order status
      await _orderRepository.updateOrderStatus(userId, orderId, orderStatus);

      //close loading screen
      Get.back();

      //show success message
      AppPopups.showSuccessToast(msg: "Order Status Changed To ${orderStatus.name} Successfully").then(
        (value) {
          //update this order in ordersTableController.filteredOrders
          OrdersTableController.instance.fetchAllUsersOrders();
        },
      );
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    }
  }

  //reorder products according to user desire
  Future<void> reOrderOrders(String orderby, bool ascending) async {
    initialSortingValue.value = orderby;
    switch (orderby) {
      case "id":
        ascending
            ? allUsersOrders.sort((a, b) => a.id.substring(0, 5).compareTo(b.id.substring(0, 5)))
            : allUsersOrders.sort(
                (a, b) => b.id.substring(0, 5).compareTo(a.id.substring(0, 5)),
              );
        break;

      default:
        {
          ascending
              ? allUsersOrders.sort((a, b) => a.id.substring(0, 5).compareTo(b.id.substring(0, 5)))
              : allUsersOrders.sort(
                  (a, b) => b.id.substring(0, 5).compareTo(a.id.substring(0, 5)),
                );
          allUsersOrders.refresh();
          break;
        }
    }
  }
}
