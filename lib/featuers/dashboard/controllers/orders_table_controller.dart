import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/controllers/order/order_controller.dart';
import '../../../data/models/order/order_model.dart';

class OrdersTableController extends GetxController {
  //instant creator
  static OrdersTableController get instance => Get.find();

  //instant of order controller
  final OrderController _orderController = Get.put(OrderController());

  //ordersList
  final RxList<OrderModel> ordersList = <OrderModel>[].obs;

  //is loading
  final RxBool isLoading = false.obs;

  //selected sorting value
  final RxString selectedSortingValue = "id".obs;

  //isSortingAssinding
  final RxBool isSortingAssinding = true.obs;

  //text controller
  final Rx<TextEditingController> searchController = TextEditingController().obs;

  //filter data
  final RxList<OrderModel> filteredOrders = <OrderModel>[].obs;

  //on init
  @override
  void onInit() {
    //fetching all users orders
    fetchAllUsersOrders();
    super.onInit();
  }

  //fetch all users orders
  Future<void> fetchAllUsersOrders() async {
    //start loading
    isLoading.value = true;
    // Fetch all users orders
    await _orderController.fetchAllUsersOrders();
    // Update the orders list
    ordersList.value = _orderController.allUsersOrders;
    //set filtered orders
    filteredOrders.value = _orderController.allUsersOrders;
    //stop loading state
    isLoading.value = false;
  }

  //reorder Orders
  Future<void> reOrderOrders(String sortingValue, bool ascending) async {
    //start loading
    isLoading.value = true;
    //change the state of selected sorting value
    selectedSortingValue.value = sortingValue;
    //reorder orders
    await _orderController.reOrderOrders(sortingValue, ascending);
    //assing the new value of ordersList
    ordersList.value = _orderController.allUsersOrders;
    // change the sorting value
    isSortingAssinding.value = !isSortingAssinding.value;
    // Update the loading state
    isLoading.value = false;
  }

  //search order
  Future<void> searchOrder() async {
    isLoading.value = true;

    if (searchController.value.text.isEmpty) {
      // If the search term is empty, reset the filtered products to all products
      isLoading.value = false;
      filteredOrders.value = _orderController.allUsersOrders;
      return;
    }

    //search in every product in allproducts by product title
    var data = _orderController.allUsersOrders.where((order) => order.id.toLowerCase().contains(searchController.value.text.toLowerCase())).toList();

    if (searchController.value.text.isNotEmpty && filteredOrders.isEmpty) {
      // If the search term is less than 3 characters, do not perform the search
      filteredOrders.value = _orderController.allUsersOrders;

      // Update the loading state
      isLoading.value = false;
      // end and return
      return;
    } else {
      //filter the products
      filteredOrders.value = data;
      //refresh filteredOrders
      filteredOrders.refresh();
      // Update the loading state
      isLoading.value = false;
    }
  }
}
