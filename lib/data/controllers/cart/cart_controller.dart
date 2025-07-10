import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/local_storage/app_local_storage.dart';
import '../../../utils/popups/app_popups.dart';
import '../../models/cart_item/cart_item_model.dart';
import '../../models/products/product_model.dart';

class CartController extends GetxController {
//*******************************************instance creator***************************************/
  //insance creator
  static CartController get instance => Get.find();

//******************************************* variabels *******************************************/

  //numbers of all items in the cart
  RxInt cartItemsNumber = 0.obs;

  //cart items list
  RxList<CartItemModel> cartItemsList = <CartItemModel>[].obs;

  //total invoice amount
  RxDouble itemsTotalAmount = 0.0.obs;

  //promo code controller
  Rx<TextEditingController> promoCodeController = TextEditingController().obs;

  //promo code message
  RxString promoCodeMessage = "No Promo Code Used : (-%0.0)".obs;

  //promo code discount
  RxDouble promoCodeDiscount = 0.0.obs;

  //promo code message color
  Rx<Color> promoCodeMessageColor = AppColors.black.obs;

  //order total amount
  RxDouble orderTotalAmount = 0.0.obs;

//*******************************************getters & sitters*******************************************/

  //get items Total amount
  double get getItemsTotalAmount {
    _calculateItemsTotalAmount();
    return itemsTotalAmount.value;
  }

//*******************************************overrided methods*******************************************/

  @override
  void onInit() {
    super.onInit();
    _getCartItemsFromStorage();
  }

//*******************************************public methods*******************************************/

  void calculateOrderTotalAmount() {
    // calculate order with fees & set orderTotalAmount
    _calculateOrderAmountWithFees();

    //if promocode is not null calculate order with promo code & set orderTotalAmount
    if (_checkPromoCode() != null) {
      applayPromoCode();
    }
  }

  //add item with default variations
  void addItemWithDefaultVariations(Product product) {
    //check if the product is exist
    if (!isProductExist(product.id)) {
      //add the item to cart itme list
      cartItemsList.add(CartItemModel(
        productId: product.id,
        itemId: product.productVariations.toString(),
        title: product.title,
        price: product.price,
        image: product.images.first,
        quantity: 1,
        brandName: product.brand.name,
        selectedVariation: product.productVariations[0].attributeValues,
      ));

      //refreshData
      _refreshData();

      //show added message
      AppPopups.showSuccessSnackBar(title: "added to the cart", message: "you can check it in the cart page");
    } else {
      //remove the item frome cart item list
      cartItemsList.removeWhere((element) => element.productId == product.id);

      //refreshData
      _refreshData();

      //show removed message
      AppPopups.showWarningSnackBar(title: "removed from cart", message: "removed from cart successfully");
    }
  }

  //add item with deferante variation to the cart
  void addItemToCart(CartItemModel cartItem) {
    //check if the same items is exist with the same variations
    int index = cartItemsList.indexWhere((element) => element.productId == cartItem.productId && element.itemId == cartItem.itemId);
    if (index == -1) {
      cartItemsList.add(cartItem);
      _refreshData();
    } else {
      int perviousCartItemQuantity = cartItemsList[index].quantity;
      cartItemsList[index] = CartItemModel(
        productId: cartItem.productId,
        itemId: cartItem.itemId,
        title: cartItem.title,
        price: cartItem.price,
        image: cartItem.image,
        quantity: perviousCartItemQuantity + cartItem.quantity,
        brandName: cartItem.brandName,
        selectedVariation: cartItem.selectedVariation,
      );
      _refreshData();
    }
  }

  //is product exist(check by product id only)
  bool isProductExist(String productId) {
    if (cartItemsList.isEmpty) {
      return false;
    } else {
      bool result = cartItemsList.any((element) => element.productId == productId);
      return result;
    }
  }

  //remove item from cart items list
  void removeItem(CartItemModel cartItem) {
    cartItemsList.removeWhere(
      (element) => (element.productId == cartItem.productId && element.itemId == cartItem.itemId),
    );
    _refreshData();
  }

  //get product count
  int getAddedItemsNumber(String productId) {
    List<CartItemModel> result = cartItemsList.where((element) => element.productId == productId).toList();
    int counter = 0;
    for (var i = 0; i < result.length; i++) {
      counter += result[i].quantity;
    }
    return counter;
  }

  //increas one item
  void increasOneIte(CartItemModel cartItem) {
    int index = cartItemsList.indexWhere((element) => (element.productId == cartItem.productId && element.itemId == cartItem.itemId));
    if (index != -1) {
      CartItemModel data = cartItemsList[index];
      cartItemsList[index] = CartItemModel(
        productId: data.productId,
        itemId: data.itemId,
        title: data.title,
        price: data.price,
        image: data.image,
        quantity: data.quantity + 1,
        brandName: data.brandName,
        selectedVariation: data.selectedVariation,
      );
    }
    _refreshData();
  }

  //decreas one item from cart
  void decreasOneItem(CartItemModel cartItem) {
    int index = cartItemsList.indexWhere((element) => (element.productId == cartItem.productId && element.itemId == cartItem.itemId));
    if (cartItem.quantity == 1) {
      removeItem(cartItem);
    } else if (index != -1) {
      CartItemModel data = cartItemsList[index];
      cartItemsList[index] = CartItemModel(
        productId: data.productId,
        itemId: data.itemId,
        title: data.title,
        price: data.price,
        image: data.image,
        quantity: data.quantity - 1,
        brandName: data.brandName,
        selectedVariation: data.selectedVariation,
      );
    }
    _refreshData();
  }

  //calculate shipping fee price
  double calculateShippingFeePrice() {
    return itemsTotalAmount.value * 0.05;
  }

  //calculate tax fee price
  double calculateTaxFeePrice() {
    return itemsTotalAmount.value * 0.14;
  }

  //applay promo code
  void applayPromoCode() {
    double? result = _checkPromoCode();
    if (result != null && result != 0.0) {
      promoCodeMessage.value = "Promo Code Applayed : (-%${promoCodeController.value.text})";
      promoCodeMessageColor.value = AppColors.success;
      promoCodeDiscount.value = itemsTotalAmount * ((double.parse(promoCodeController.value.text)) / 100);
      _calculateTotalPriceWithPromoCode(result);
    } else if (result == null) {
      promoCodeMessage.value = "Invalid Promo Code: (-%0.0)";
      promoCodeMessageColor.value = AppColors.error;
      promoCodeDiscount.value = 0.0;
      _calculateTotalPriceWithPromoCode(0);
    } else {
      promoCodeMessage.value = "please inter promo code : (-%0.0)";
      promoCodeMessageColor.value = AppColors.warning;
      promoCodeDiscount.value = 0.0;
      _calculateTotalPriceWithPromoCode(0);
    }
  }

  //remove All CartItems and romove it frome local storage
  void removeAllCartItems() {
    cartItemsList.clear();
    _refreshData();
  }
//*******************************************priveate methods*******************************************/

  //calculate items total price
  void _calculateItemsTotalAmount() {
    double price = 0;
    for (var i = 0; i < cartItemsList.length; i++) {
      price += cartItemsList[i].price * cartItemsList[i].quantity;
    }
    itemsTotalAmount.value = price;
  }

  //saving favorit data in localStorage
  void _saveCartItemsToLocalStorage() {
    final data = {
      for (int i = 0; i < cartItemsList.length; i++) "$i": cartItemsList[i].toJson(),
    };
    final incodedCartItems = json.encode(data);

    AppLocalStorage.instance().saveData("cartItems", incodedCartItems);
  }

  //calculate total amount with fees
  double _calculateOrderAmountWithFees() {
    orderTotalAmount.value = itemsTotalAmount.value + calculateShippingFeePrice() + calculateTaxFeePrice();
    return orderTotalAmount.value;
  }

  //getcartitems from storage
  void _getCartItemsFromStorage() {
    final json = AppLocalStorage.instance().readData("cartItems");
    if (json != null) {
      final storedCartItems = jsonDecode(json) as Map<String, dynamic>;
      cartItemsList.value = storedCartItems.entries.map((e) => CartItemModel.fromJson(e.value)).toList();
      _refreshData();
    }
  }

  //calculate cart items number
  void _calculateCartItemsNumber() {
    int itemsCounter = 0;
    for (var i = 0; i < cartItemsList.length; i++) {
      itemsCounter += cartItemsList[i].quantity;
    }
    cartItemsNumber.value = itemsCounter;
  }

  //refresh data
  void _refreshData() {
    cartItemsList;
    _calculateCartItemsNumber();
    _calculateItemsTotalAmount();
    _saveCartItemsToLocalStorage();
  }

  //check promo code
  double? _checkPromoCode() {
    var result = double.tryParse(promoCodeController.value.text);
    if (promoCodeController.value.text.isEmpty) {
      return 0.0;
    } else if (result == null) {
      return null;
    } else if (result > 0.0 && result < 40) {
      return result;
    } else {
      return null;
    }
  }

  //calculate total after using promo code
  double _calculateTotalPriceWithPromoCode(double promoCodeRatet) {
    if (itemsTotalAmount.value == 0) {
      return orderTotalAmount.value;
    }
    orderTotalAmount.value = calculateShippingFeePrice() + calculateTaxFeePrice() + (itemsTotalAmount.value - (itemsTotalAmount.value * (promoCodeRatet / 100)));
    return orderTotalAmount.value;
  }
}
