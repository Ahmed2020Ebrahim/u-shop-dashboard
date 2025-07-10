import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/controllers/brands/brands_controller.dart';
import 'package:ushop_web/data/models/brand/brand_model.dart';
import 'package:ushop_web/featuers/brands/controllers/add_brand_controller.dart';

import '../../../common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import '../../../routes/app_routs.dart';

class BrandsTableController extends GetxController {
  //instant creator
  static BrandsTableController get instance => Get.find();

  //instant of brands controller
  final BrandsController _brandController = Get.put(BrandsController());

  //brands List
  final RxList<BrandModel> brandsList = <BrandModel>[].obs;

  //is loading
  final RxBool isLoading = false.obs;

  //selected sorting value
  final RxString selectedSortingValue = "name".obs;

  //isSortingAssinding
  final RxBool isSortingAssinding = true.obs;

  //text controller
  final Rx<TextEditingController> searchController = TextEditingController().obs;

  //filter data
  final RxList<BrandModel> filteredbrands = <BrandModel>[].obs;

  //on init
  @override
  void onInit() {
    //fetching all  brands
    fetchAllBrands();
    super.onInit();
  }

  //fetch all brands
  Future<void> fetchAllBrands() async {
    //start loading
    isLoading.value = true;
    // Fetch all brands
    await _brandController.fatchBrands();
    // Update the brands list
    brandsList.value = _brandController.allBrands;
    //set filtered brands
    filteredbrands.value = _brandController.allBrands;
    //stop loading state
    isLoading.value = false;
  }

  //reorder brands
  Future<void> reOrderBrands(String sortingValue, bool ascending) async {
    //start loading
    isLoading.value = true;
    //change the state of selected sorting value
    selectedSortingValue.value = sortingValue;
    //reorder brands
    await _brandController.reOrderBrands(sortingValue, ascending);
    //assing the new value of brandslist
    brandsList.value = _brandController.allBrands;
    // change the sorting value
    isSortingAssinding.value = !isSortingAssinding.value;
    // Update the loading state
    isLoading.value = false;
  }

  //search brand
  Future<void> searchBrand() async {
    isLoading.value = true;

    if (searchController.value.text.isEmpty) {
      // If the search term is empty, reset the filtered brands to all products
      isLoading.value = false;
      filteredbrands.value = _brandController.allBrands;
      return;
    }

    //search in every brand in allbrands by brand name
    var data = _brandController.allBrands.where((brand) => brand.name.toLowerCase().contains(searchController.value.text.toLowerCase())).toList();

    if (searchController.value.text.isNotEmpty && filteredbrands.isEmpty) {
      //set the filterd data
      filteredbrands.value = _brandController.allBrands;

      // Update the loading state
      isLoading.value = false;
      // end and return
      return;
    } else {
      //filter the brands
      filteredbrands.value = data;
      //refresh filteded brands
      filteredbrands.refresh();
      // Update the loading state
      isLoading.value = false;
    }
  }

  //remove brand
  Future<void> removeBrand(int index) async {
    //start loading
    isLoading.value = true;
    // Fetch all users brand
    await _brandController.removeBrand(_brandController.allBrands[index].id);
    // Update the brand list
    brandsList.value = _brandController.allBrands;
    //set filtered orders
    filteredbrands.value = _brandController.allBrands;
    //stop loading state
    isLoading.value = false;
  }

  //onEdit
  Future<void> onEditBrand(int index) async {
    AddBrandController addBrandController = Get.put(AddBrandController());
    addBrandController.currentBrand.value = filteredbrands[index];
    addBrandController.setDataToUpdate(filteredbrands[index]);
    AppNavigationController appNavigationController = Get.find();
    appNavigationController.appNavigate(AppRouts.editBrand);
  }
}
