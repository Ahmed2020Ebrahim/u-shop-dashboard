import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/common/widgets/dialogs/dialoges.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/data/controllers/order/order_controller.dart';
import 'package:ushop_web/data/controllers/user/user_controller.dart';
import 'package:ushop_web/data/models/user/user_model.dart';
import 'package:ushop_web/routes/app_routs.dart';
import 'package:ushop_web/utils/constants/app_images.dart';

import 'customer_controller.dart';

class CustomersTableController extends GetxController {
  //instant creator
  static CustomersTableController get instance => Get.find();

  //instant of user controller
  final UserController _userController = Get.put(UserController());

  //customer controller
  final CustomerController customerController = Get.put(CustomerController());

  //orders controller
  final OrderController ordersController = Get.put(OrderController());

  //user List
  final RxList<UserModel> usersList = <UserModel>[].obs;

  //is loading
  final RxBool isLoading = false.obs;

  //selected sorting value
  final RxString selectedSortingValue = "name".obs;

  //isSortingAssinding
  final RxBool isSortingAssinding = true.obs;

  //text controller
  final Rx<TextEditingController> searchController = TextEditingController().obs;

  //filter data
  final RxList<UserModel> filteredUsers = <UserModel>[].obs;

  //on init
  @override
  void onInit() {
    //fetching all  users
    fetchAllUsers();
    super.onInit();
  }

  //fetch all brands
  Future<void> fetchAllUsers() async {
    //start loading
    isLoading.value = true;
    // Fetch all users
    await _userController.fetchAllUsers();
    // Update the users list
    usersList.value = _userController.allUsers;
    //set filtered users
    filteredUsers.value = _userController.allUsers;
    //stop loading state
    isLoading.value = false;
  }

  //reorder users
  Future<void> reOrderCustomers(String sortingValue, bool ascending) async {
    //start loading
    isLoading.value = true;
    //change the state of selected sorting value
    selectedSortingValue.value = sortingValue;
    //reorder users
    await _userController.reOrderUsers(sortingValue, ascending);
    //assing the new value of userslist
    usersList.value = _userController.allUsers;
    // change the sorting value
    isSortingAssinding.value = !isSortingAssinding.value;
    // Update the loading state
    isLoading.value = false;
  }

  //search brand
  Future<void> searchUsers() async {
    isLoading.value = true;

    if (searchController.value.text.isEmpty) {
      // If the search term is empty, reset the filtered users
      isLoading.value = false;
      filteredUsers.value = _userController.allUsers;
      return;
    }

    //search in every user in allusers by username
    var data = _userController.allUsers.where((user) => user.userName.toLowerCase().contains(searchController.value.text.toLowerCase())).toList();

    if (searchController.value.text.isNotEmpty && filteredUsers.isEmpty) {
      //set the filterd data
      filteredUsers.value = _userController.allUsers;

      // Update the loading state
      isLoading.value = false;
      // end and return
      return;
    } else {
      //filter the brands
      filteredUsers.value = data;
      //refresh filteded brands
      filteredUsers.refresh();
      // Update the loading state
      isLoading.value = false;
    }
  }

  //onShow
  Future<void> onShow(int index) async {
    Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 120, height: 120));

    customerController.currentCustomer.value = filteredUsers[index];
    await customerController.getOrderByUserId(customerController.currentCustomer.value.id);
    await customerController.getSelectedAddress();
    customerController.currentUserOrders.refresh();

    Get.back();
    AppNavigationController appNavigationController = Get.find();
    appNavigationController.appNavigate(AppRouts.customerDetails);
  }
}
