import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/data/controllers/category/category_controller.dart';
import 'package:ushop_web/data/models/category/category_model.dart';
import 'package:ushop_web/featuers/categories/controllers/add_category_controller.dart';
import 'package:ushop_web/routes/app_routs.dart';

class CategoriesTableController extends GetxController {
  //instant creator
  static CategoriesTableController get instance => Get.find();

  //instant of category controller
  final CategoryController _categoryController = Get.put(CategoryController());

  //brands List
  final RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;

  //is loading
  final RxBool isLoading = false.obs;

  //selected sorting value
  final RxString selectedSortingValue = "name".obs;

  //isSortingAssinding
  final RxBool isSortingAssinding = true.obs;

  //text controller
  final Rx<TextEditingController> searchController = TextEditingController().obs;

  //filter data
  final RxList<CategoryModel> filteredCategories = <CategoryModel>[].obs;

  //categoryTabelSelectedIndexesList
  final RxList<int> categoryTabelSelectedIndexesList = <int>[].obs;

  //on init
  @override
  void onInit() {
    //fetching all users orders
    fetchAllCategories();
    super.onInit();
  }

  //fetch all users orders
  Future<void> fetchAllCategories() async {
    //start loading
    isLoading.value = true;
    // Fetch all users orders
    await _categoryController.fatchCategories();
    // Update the orders list
    categoriesList.value = _categoryController.allCategories;
    //set filtered orders
    filteredCategories.value = _categoryController.allCategories;
    //stop loading state
    isLoading.value = false;
  }

  //reorder categories
  Future<void> reOrderCategories(String sortingValue, bool ascending) async {
    //start loading
    isLoading.value = true;
    //change the state of selected sorting value
    selectedSortingValue.value = sortingValue;
    //reorder categories
    await _categoryController.reOrderCategories(sortingValue, ascending);
    //assing the new value of categories list
    categoriesList.value = _categoryController.allCategories;
    // change the sorting value
    isSortingAssinding.value = !isSortingAssinding.value;
    // Update the loading state
    isLoading.value = false;
  }

  //remove category
  Future<void> removeCategory(int index) async {
    //start loading
    isLoading.value = true;
    // Fetch all users orders
    await _categoryController.removeCategory(_categoryController.allCategories[index].id);
    // Update the orders list
    categoriesList.value = _categoryController.allCategories;
    //set filtered orders
    filteredCategories.value = _categoryController.allCategories;
    //stop loading state
    isLoading.value = false;
  }

  //onEdit
  Future<void> onEditCategory(int index) async {
    AddCategoryController addCategoryController = Get.put(AddCategoryController());
    addCategoryController.currentCategory.value = filteredCategories[index];
    addCategoryController.setValuesToUpdate(filteredCategories[index]);
    AppNavigationController appNavigationController = Get.find();
    appNavigationController.appNavigate(AppRouts.updateCategory);
  }

  //search categories
  Future<void> searchCategory() async {
    isLoading.value = true;

    if (searchController.value.text.isEmpty) {
      // If the search term is empty, reset the filtered categories to all categories
      isLoading.value = false;
      filteredCategories.value = _categoryController.allCategories;
      return;
    }

    //search in every brand in allcategories by brand name
    var data = _categoryController.allCategories.where((category) => category.name.toLowerCase().contains(searchController.value.text.toLowerCase())).toList();

    if (searchController.value.text.isNotEmpty && filteredCategories.isEmpty) {
      //set the filterd data
      filteredCategories.value = _categoryController.allCategories;

      // Update the loading state
      isLoading.value = false;
      // end and return
      return;
    } else {
      //filter the categories
      filteredCategories.value = data;
      //refresh filteded categories
      filteredCategories.refresh();
      // Update the loading state
      isLoading.value = false;
    }
  }
}
