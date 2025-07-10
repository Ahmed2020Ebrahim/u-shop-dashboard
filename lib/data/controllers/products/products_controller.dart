import 'package:get/get.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/app_popups.dart';
import '../../models/brand/brand_model.dart';
import '../../models/category/category_model.dart';
import '../../models/products/product_model.dart';
import '../../repositories/product_repository/product_repository.dart';
import '../category/category_controller.dart';

class ProductController extends GetxController {
  //instance creator
  static ProductController get instance => Get.find();

  //product repository
  final _productRepository = Get.put(ProductRepository());

  //category instance
  final _categoryInstance = Get.put(CategoryController());

  //all products
  RxList<Product> allProducts = <Product>[].obs;

  //featured products
  RxList<Product> featuredProducts = <Product>[].obs;

  //loader
  Rx<bool> loader = false.obs;

  //sorting values
  RxList<String> sortingValues = <String>["Name", "Heigher Price", "Lower Price", "Sale", "Newest", "Popularity"].obs;

  //initial sorting value
  Rx<String> initialSortingValue = "Name".obs;

  //spicific brand products
  RxList<Product> currentBrandProducts = <Product>[].obs;

  //current product
  Rx<Product> currentProduct = Product.emptyProduct().obs;

  //category product
  RxList<Product> currentCategoryProducts = <Product>[].obs;

  //search products
  RxList<Product> searchProducts = <Product>[].obs;

  //current category
  Rx<CategoryModel> currentCategory = CategoryModel.emptyCategoryModel().obs;

  //products according to productType
  RxMap<String, dynamic> productsAccoridingToTyp = <String, dynamic>{}.obs;

  @override
  void onInit() async {
    await fatchProducts();
    super.onInit();
  }

  //fatch products
  Future<void> fatchProducts() async {
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
      final data = await _productRepository.getProducts();

      //asign allProducts
      allProducts.assignAll(data);

      //asign featuredProducts
      featuredProducts.assignAll(data.where((element) => element.isFeatured == true).toList());

      //stop loading
      loader.value = false;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      loader.value = false;
    }
  }

  //upload product
  Future<void> uploadProduct(Product product) async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }

      //upload product
      await _productRepository.uploadProduct(product);
    } catch (e) {
      throw e.toString();
    }
  }

  //upload product
  Future<void> updateProduct(Product product) async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }

      //upload product
      await _productRepository.updateProduct(product);
    } catch (e) {
      throw e.toString();
    }
  }

  //search by name
  Future<void> search(String productName) async {
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
      final data = await _productRepository.searchProductsByName(productName);

      //asign allProducts
      searchProducts.assignAll(data);

      //stop loading
      loader.value = false;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      loader.value = false;
    }
  }

  //reorder products according to user desire
  Future<void> reOrderProducts(String orderby, bool ascending) async {
    initialSortingValue.value = orderby;

    switch (orderby) {
      case "name":
        ascending ? allProducts.sort((a, b) => a.title.compareTo(b.title)) : allProducts.sort((a, b) => b.title.compareTo(a.title));
        break;
      case "price":
        ascending ? allProducts.sort((a, b) => a.price.compareTo(b.price)) : allProducts.sort((a, b) => b.price.compareTo(a.price));
      case "brand":
        ascending ? allProducts.sort((a, b) => a.brand.name.compareTo(b.brand.name)) : allProducts.sort((a, b) => b.brand.name.compareTo(a.brand.name));
      case "stock":
        ascending ? allProducts.sort((a, b) => a.stock.compareTo(b.stock)) : allProducts.sort((a, b) => b.stock.compareTo(a.stock));
        break;
      case "sale":
        ascending ? allProducts.sort((a, b) => a.salePrice.compareTo(b.salePrice)) : allProducts.sort((a, b) => b.salePrice.compareTo(a.salePrice));
        break;
      default:
        {
          ascending ? allProducts.sort((a, b) => a.title.compareTo(b.title)) : allProducts.sort((a, b) => b.title.compareTo(a.title));
          break;
        }
    }
  }

  //remove product
  Future<void> removeProduct(String id) async {
    try {
      // start loader
      loader.value = true;
      // fatch all product
      await _productRepository.removeProduct(id);

      //remove frome all product
      allProducts.removeWhere((element) => element.id == id);

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

  //get products according to brand name
  Future<void> getBrandProducts(BrandModel brand) async {
    currentBrandProducts.assignAll(allProducts.where((element) => element.brand.id == brand.id).toList());
    // Get.to(() => const SingleBrandProductsScreen());
  }

  //set current product
  Future<void> setCurrentProduct(Product product) async {
    currentProduct.value = product;
    // Get.to(() => const ProductDetailsScreen());
  }

  //get products according to categoryId
  Future<void> getCategoryProducts(String categoryId, CategoryModel categoryModel) async {
    currentCategoryProducts.assignAll(allProducts.where((element) => element.categoryId == categoryId).toList());
    currentCategory.value = categoryModel;
    await getCategoryAccordingToProductType(categoryModel);
  }

  //get products according to productType
  Future<void> getCategoryAccordingToProductType(CategoryModel categoryModel) async {
    Map<String, dynamic> data = {};
    final categories = _categoryInstance.featuredCategories;
    for (int e = 0; e < categories.length; e++) {
      int? lenth = categories[e].subCategories!.length;
      if (lenth != 0 && categories[e].subCategories!.isNotEmpty) {
        for (int i = 0; i < allProducts.length; i++) {
          if (categories[e].subCategories!.contains(allProducts[i].productType) && categoryModel.subCategories!.contains(allProducts[i].productType)) {
            if (data.containsKey(allProducts[i].productType)) {
              data.update(allProducts[i].productType, (value) {
                List<Product> data = value;
                data.add(allProducts[i]);
                return data;
              });
            } else {
              data.putIfAbsent(allProducts[i].productType, () => [allProducts[i]]);
            }
          }
        }
      }
    }

    productsAccoridingToTyp.assignAll(data);
  }

  //get products according to category id
  List<Product> getProductsAccoringtocategoryId(String categoryId) {
    currentCategoryProducts.assignAll(allProducts.where((element) => element.categoryId == categoryId).toList());
    return currentCategoryProducts;
  }

  //get product by id
  Product getProductById(String productId) {
    return allProducts.firstWhere(
      (element) => element.id == productId,
    );
  }
}
