import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/controllers/banners/banner_controller.dart';
import 'package:ushop_web/data/models/banners/banners_model.dart';
import 'package:ushop_web/featuers/bannars/controllers/add_banner_controller.dart';

import '../../../common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import '../../../routes/app_routs.dart';

class BannersTableController extends GetxController {
  //instant creator
  static BannersTableController get instance => Get.find();

  //instant of banner controller
  final BannerController _bannerController = Get.put(BannerController());

  //banners List
  final RxList<BannerModel> bannersList = <BannerModel>[].obs;

  //is loading
  final RxBool isLoading = false.obs;

  //text controller
  final Rx<TextEditingController> searchController = TextEditingController().obs;

  //on init
  @override
  void onInit() {
    //fetching all banners
    fetchAllBanners();
    super.onInit();
  }

  //fetch all users orders
  Future<void> fetchAllBanners() async {
    //start loading
    isLoading.value = true;
    // Fetch all users orders
    await _bannerController.fatchBanners();
    // Update the orders list
    bannersList.value = _bannerController.allBanners;
    //stop loading state
    isLoading.value = false;
  }

  //remove banner
  Future<void> removeBanner(int index) async {
    //start loading
    isLoading.value = true;
    // Fetch all users orders
    await _bannerController.removeBanner(_bannerController.allBanners[index].id);
    // Update the orders
    bannersList.value = _bannerController.allBanners;
    //stop loading state
    isLoading.value = false;
  }

  //onEdit
  Future<void> onEditBanner(int index) async {
    AddBannerController addBannerController = Get.put(AddBannerController());
    addBannerController.currentBanner.value = bannersList[index];
    addBannerController.setValuesToUpdate(bannersList[index]);
    AppNavigationController appNavigationController = Get.find();
    appNavigationController.appNavigate(AppRouts.addBanner);
  }
}
