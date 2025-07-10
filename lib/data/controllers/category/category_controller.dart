import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/common/widgets/dialogs/dialoges.dart';
import 'package:ushop_web/utils/constants/app_images.dart';
import '../../../utils/popups/app_popups.dart';
import '../../models/category/category_model.dart';
import '../../models/products/product_model.dart';
import '../../repositories/category_repository/category_repository.dart';
import '../products/products_controller.dart';

class CategoryController extends GetxController with GetSingleTickerProviderStateMixin {
  // instance creator
  static CategoryController get instance => Get.find();

  //category repository instance
  Rx<bool> loader = false.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final _categoryRepository = Get.put(CategoryRepository());

  //tab controller
  late TabController tabController;

  //on init method
  @override
  void onInit() async {
    await fatchCategories();
    tabController = TabController(length: featuredCategories.length, vsync: this);
    super.onInit();
  }

  //fatch all categories
  Future<void> fatchCategories() async {
    try {
      // start loader
      loader.value = true;
      // fatch all categories
      final categories = await _categoryRepository.getCategories();
      // update allCategories
      allCategories.assignAll(categories);

      //update featured categories
      featuredCategories.assignAll(categories.where((element) => element.isFeatured));
      // stop loader
      loader.value = false;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loader
      loader.value = false;
    }
  }

  //fatch categories according to id
  Map<String, List<Product>> fatchFeaturedCategorysAndItsProductsById() {
    final productController = Get.find<ProductController>();
    Map<String, List<Product>> data = {};

    for (var i = 0; i < featuredCategories.length; i++) {
      final products = productController.getProductsAccoringtocategoryId(featuredCategories[i].id);
      data[featuredCategories[i].id] = List<Product>.from(products);
    }
    return data;
  }

  //reorder categoris according to user desire
  Future<void> reOrderCategories(String orderby, bool ascending) async {
    switch (orderby) {
      case "name":
        ascending ? allCategories.sort((a, b) => a.name.compareTo(b.name)) : allCategories.sort((a, b) => b.name.compareTo(a.name));
        break;

      default:
        {
          ascending
              ? allCategories.sort((a, b) => a.name.compareTo(b.name))
              : allCategories.sort(
                  (a, b) => b.name.compareTo(a.name),
                );

          allCategories.refresh();
          break;
        }
    }
  }

  //get category name by id
  String getCategoryNameById(String id) {
    final category = featuredCategories.firstWhere((element) => element.id == id);
    return category.name;
  }

  //remove category
  Future<void> removeCategory(String id) async {
    try {
      // start loader
      loader.value = true;
      // fatch all categories
      await _categoryRepository.removeCategory(id);

      //remove frome all category
      allCategories.removeWhere((element) => element.id == id);

      // stop loader
      loader.value = false;
      AppPopups.showSuccessToast(msg: "Deleted Successfully");
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loader
      loader.value = false;
    }
  }

  //create category
  Future<void> createCategory(CategoryModel category) async {
    try {
      // start loader
      Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 120, height: 120));
      // create category
      await _categoryRepository.createCategory(category);

      await fatchCategories();

      // stop loader
      Get.back();
      AppPopups.showSuccessToast(msg: "Category Created Successfully");
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loader
      loader.value = false;
    }
  }

  //update category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      // start loader
      Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 120, height: 120));
      // update category
      await _categoryRepository.updateCategory(category);

      await fatchCategories();

      // stop loader
      Get.back();
      AppPopups.showSuccessToast(msg: "Category Updated Successfully");
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loader
      loader.value = false;
    }
  }
}
