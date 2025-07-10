import 'dart:convert';

import 'package:get/get.dart';

import '../../../utils/helpers/network_manager.dart';
import '../../../utils/local_storage/app_local_storage.dart';
import '../../../utils/popups/app_popups.dart';
import '../../models/products/product_model.dart';
import '../../repositories/product_repository/product_repository.dart';

class FavoritesController extends GetxController {
  //instance creator
  static FavoritesController get instance => Get.find();

  //current user favorits
  final userFavoritsProductsIdList = <String, bool>{}.obs;

  //current user list of favorit product
  RxList<Product> userFavoritProductsList = <Product>[].obs;

  //loader
  Rx<bool> loader = false.obs;

  @override
  void onInit() async {
    super.onInit();
    initFavorites();
    await getFavoritProducts();
  }

  //intifavorites current user favorit
  void initFavorites() {
    final json = AppLocalStorage.instance().readData("favorites");
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      userFavoritsProductsIdList.assignAll(storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  //is the product favorite
  bool isFavorit(String productId) {
    return userFavoritsProductsIdList[productId] ?? false;
  }

  //toggle favorit product
  void toggleFavoritProduct(Product product) {
    if (!userFavoritsProductsIdList.containsKey(product.id)) {
      userFavoritsProductsIdList[product.id] = true;
      userFavoritProductsList.add(product);

      //saveFavorits to storage
      _savingFavoirtesToLocalStorage();

      //show succes masseage
      AppPopups.showSuccessSnackBar(title: "added to favorits", message: "aded to your favorits list");
    } else {
      //remove product form local storage
      AppLocalStorage.instance().removeData(product.id);

      //remove product from userfavoritsList
      userFavoritsProductsIdList.remove(product.id);
      userFavoritProductsList.removeWhere((element) => element.id == product.id);

      //savefavorits to storage
      _savingFavoirtesToLocalStorage();

      //refresh FavoritList
      userFavoritsProductsIdList.refresh();

      //show succes message when remove the product form favorit
      AppPopups.showSuccessSnackBar(title: "deleted from favorits", message: "deleted from your favorits list");
    }
  }

  //saving favorit data in localStorage
  void _savingFavoirtesToLocalStorage() {
    final incodedFavoirtsList = json.encode(userFavoritsProductsIdList);
    AppLocalStorage.instance().saveData("favorites", incodedFavoirtsList);
  }

  //favorite products function
  Future<void> getFavoritProducts() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }

      //start loading
      loader.value = true;

      //get the true values
      List<String> trueKeys = userFavoritsProductsIdList.entries
          .where((entry) => entry.value) // Filter entries where value is true
          .map((entry) => entry.key) // Extract keys
          .toList(); // Convert to list

      //fatch data
      List<Product> data = await ProductRepository.instance.getFavoritProducts(trueKeys);

      //asign data
      userFavoritProductsList.assignAll(data);

      //stop loading
      loader.value = false;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      loader.value = false;
    }
  }
}
