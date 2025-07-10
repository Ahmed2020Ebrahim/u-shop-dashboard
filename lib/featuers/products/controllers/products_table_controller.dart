import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import '../../../data/controllers/products/products_controller.dart';
import '../../../data/models/products/product_model.dart';
import '../../../routes/app_routs.dart';
import 'add_product_controller.dart';

class ProductsTableController extends GetxController {
  //instance
  static ProductsTableController get instance => Get.find();

  //product controller
  final ProductController productController = Get.find<ProductController>();

  //addproductcontroller
  final AddProductController addProductController = Get.find<AddProductController>();

  //list of products
  final RxList<Product> products = <Product>[].obs;

  //filter data
  final RxList<Product> filteredProducts = <Product>[].obs;

  //text controller
  final Rx<TextEditingController> searchController = TextEditingController().obs;

  //sorting values
  final RxMap<String, bool> sortAscending = <String, bool>{"name": false, "price": false, "stock": false, "brand": false, "date": false}.obs;
  //selected sorting value
  final RxString selectedSortingValue = "name".obs;
  //selected sorting index
  final RxInt selectedSortingIndex = 0.obs;
  //isloading
  final RxBool isLoading = false.obs;

  //is editing
  final RxBool isEditing = false.obs;

  // Function to handle row tap
  void onRowTap(int index) {
    // Handle row tap
  }

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    // Fetch products from the controller
    await productController.fatchProducts();
    // Update the products list
    products.value = productController.allProducts;

    //filter the products
    filteredProducts.value = productController.allProducts;
    // Update the loading state
    isLoading.value = false;
  }

  //reorder products
  Future<void> reOrderProducts(String sortingValue, bool ascending) async {
    isLoading.value = true;
    selectedSortingValue.value = sortingValue;
    await productController.reOrderProducts(sortingValue, ascending);
    products.value = productController.allProducts;
    // change the sorting value
    //change all sortAscending values to false
    sortAscending.forEach((key, value) {
      sortAscending[key] = false;
    });
    sortAscending[sortingValue] = ascending;
    // Update the loading state
    isLoading.value = false;
  }

  //search products
  Future<void> searchProducts() async {
    isLoading.value = true;

    if (searchController.value.text.isEmpty) {
      // If the search term is empty, reset the filtered products to all products
      isLoading.value = false;
      filteredProducts.value = productController.allProducts;
      return;
    }

    //search in every product in allproducts by product title
    var data = productController.allProducts.where((product) => product.title.toLowerCase().contains(searchController.value.text.toLowerCase())).toList();

    if (searchController.value.text.isNotEmpty && filteredProducts.isEmpty) {
      // If the search term is less than 3 characters, do not perform the search
      filteredProducts.value = productController.allProducts;

      // Update the loading state
      isLoading.value = false;
      // end and return
      return;
    } else {
      //filter the products
      filteredProducts.value = data;
      //refresh filteredproducts
      filteredProducts.refresh();
      // Update the loading state
      isLoading.value = false;
    }
  }

  //remove category
  Future<void> removeProduct(int index) async {
    //start loading
    isLoading.value = true;
    // Fetch all users products
    await productController.removeProduct(productController.allProducts[index].id);
    // Update the products list
    products.value = productController.allProducts;
    //set filtered products
    filteredProducts.value = productController.allProducts;
    //stop loading state
    isLoading.value = false;
  }

  //onEdit
  Future<void> onEditProduct(int index) async {
    AddProductController addProductController = Get.put(AddProductController());

    addProductController.setValuesToUpdate(filteredProducts[index]);

    AppNavigationController appNavigationController = Get.find();

    appNavigationController.appNavigate(AppRouts.updateProduct);
  }
}
