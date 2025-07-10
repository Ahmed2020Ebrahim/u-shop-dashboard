import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/controllers/address/address_controller.dart';
import 'package:ushop_web/data/models/address/address_model.dart';
import 'package:ushop_web/data/models/order/order_model.dart';
import 'package:ushop_web/data/models/user/user_model.dart';

import '../../../data/repositories/order_repository/order_repository.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/app_popups.dart';

class CustomerController extends GetxController {
  //instance
  static CustomerController get instance => Get.find();

  //cuurent customer
  final Rx<UserModel> currentCustomer = UserModel.empty().obs;

  //address controle
  final AddressController addressController = Get.put(AddressController());

  //order repository
  final OrderRepository _orderRepository = Get.put(OrderRepository());

  //current user orders
  final RxList<OrderModel> currentUserOrders = <OrderModel>[].obs;

  //filtered orders
  final RxList<OrderModel> filteredOrders = <OrderModel>[].obs;

  //user selected addres
  final Rx<AddressModel> currentUserSelectedAddress = AddressModel.emptyAddressModel().obs;

  //isloading
  final RxBool isLoading = false.obs;

  //text controller
  final TextEditingController searchController = TextEditingController();

  //getOrderByUserId
  Future<void> getOrderByUserId(String userId) async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }
      //start loading
      isLoading.value = true;

      //fatch data
      final data = await _orderRepository.fetchOrdersById(userId);

      //asign orders
      currentUserOrders.assignAll(data);

      //filter order
      filteredOrders.value = currentUserOrders;

      //stop loading
      isLoading.value = false;
    } catch (e) {
      //show error message
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loading
      isLoading.value = false;
    }
  }

  //calculate all current user order totals
  double calculateTotal() {
    double total = 0.0;
    for (var order in currentUserOrders) {
      total += order.orderTotalAmount;
    }
    return total;
  }

  //search products
  Future<void> searchProducts() async {
    isLoading.value = true;

    if (searchController.text.isEmpty) {
      // If the search term is empty, reset the filtered orders to all current user orders
      isLoading.value = false;
      filteredOrders.value = currentUserOrders;
      return;
    }

    //search in every order in currentuserorders by product title
    var data = currentUserOrders.where((order) => order.id.toLowerCase().contains(searchController.text.toLowerCase())).toList();

    if (searchController.text.isNotEmpty && filteredOrders.isEmpty) {
      filteredOrders.value = currentUserOrders;

      // Update the loading state
      isLoading.value = false;
      // end and return
      return;
    } else {
      //filter the order
      filteredOrders.value = data;
      //refresh filteredproducts
      filteredOrders.refresh();
      // Update the loading state
      isLoading.value = false;
    }
  }

  //get last order date
  int? getDaysSinceLastOrder() {
    if (currentUserOrders.isEmpty) return null;

    // Get the latest order date
    currentUserOrders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    final lastOrderDate = currentUserOrders.first.orderDate;

    // Calculate the difference from today
    final now = DateTime.now();
    final difference = now.difference(lastOrderDate).inDays;

    return difference;
  }

  String? getLastOrderId() {
    if (currentUserOrders.isEmpty) return null;

    // Get the latest order date
    currentUserOrders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    final lastOrder = currentUserOrders.first;

    return lastOrder.id;
  }

  //get orders average
  double getOrdersAverage() {
    double total = 0.0;
    for (var element in currentUserOrders) {
      total = element.orderTotalAmount;
    }
    return total / currentUserOrders.length;
  }

  //get selected address
  Future<void> getSelectedAddress() async {
    final selectedAddress = await addressController.getSelectedUserAdressById(currentCustomer.value.id);
    currentUserSelectedAddress.value = selectedAddress;
  }
}
