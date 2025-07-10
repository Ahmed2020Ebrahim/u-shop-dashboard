// import 'package:get/get.dart';
// import '../../../utils/popups/app_popups.dart';
// import '../../models/cart_item/cart_item_model.dart';
// import '../../models/products/attreibute_values.dart';
// import '../../models/products/product_variations_model.dart';
// import '../cart/cart_controller.dart';
// import '../products/products_controller.dart';

// class VariationController extends GetxController {
//   //instance creator
//   static VariationController get instance => Get.find();

//   //variabels
//   Rx<ProductVariation> selectedProductVariation = ProductVariation.empty().obs;
//   RxMap<String, String> selectedAttributes = <String, String>{}.obs;
//   RxMap<String, String> defaultAttributesValues = <String, String>{}.obs;
//   RxList<String> productColors = <String>[].obs;
//   RxList<String> productSizes = <String>[].obs;
//   Rx<CartItemModel> currentCartItem = CartItemModel.emptyCartItem().obs;
//   final _cartController = CartController.instance;

//   //oninit
//   @override
//   void onInit() {
//     _setInitData();
//     super.onInit();
//   }

//   //*****methods******//

//   //add to cart
//   void addToCart() {
//     //check if the currentCartItem is not empty
//     if (currentCartItem.value.quantity == 0) {
//       AppPopups.showWarningSnackBar(title: "No Item In The Cart", message: "please select the item quantity first");
//       return;
//     }
//     //add the current cart item to the cart
//     _cartController.addItemToCart(currentCartItem.value);
//     //show success message
//     AppPopups.showSuccessSnackBar(title: "Added To The Cart", message: "you can check it in the cart page");
//     //reset variation
//     _reSetCurrentCartItem();
//   }

//   //on increase item
//   void onIncreaseItem() {
//     CartItemModel data = currentCartItem.value;
//     currentCartItem.value = CartItemModel(
//       productId: data.productId,
//       itemId: selectedAttributes.toString(),
//       title: data.title,
//       price: data.price,
//       image: data.image,
//       quantity: data.quantity + 1,
//       brandName: data.brandName,
//       selectedVariation: data.selectedVariation,
//     );
//   }

//   //on decrease item
//   void onDecreaseItem() {
//     CartItemModel data = currentCartItem.value;
//     if (data.quantity >= 1) {
//       currentCartItem.value = CartItemModel(
//         productId: data.productId,
//         itemId: selectedAttributes.toString(),
//         title: data.title,
//         price: data.price,
//         image: data.image,
//         quantity: data.quantity - 1,
//         brandName: data.brandName,
//         selectedVariation: data.selectedVariation,
//       );
//     }
//   }

//   // //onAttributeSelected
//   // void onAttributeSelected(String attributeName, String attributeValue) {
//   //   if (attributeName == 'color') {
//   //     AttreibuteValues attributes = AttreibuteValues(color: attributeValue, size: selectedAttributes.value.size);
//   //     selectedAttributes.value = attributes;
//   //     CartItemModel data = currentCartItem.value;
//   //     currentCartItem.value = CartItemModel(
//   //       productId: data.productId,
//   //       itemId: "${selectedAttributes.value.color}${selectedAttributes.value.size}",
//   //       title: data.title,
//   //       price: data.price,
//   //       image: data.image,
//   //       quantity: 0,
//   //       brandName: data.brandName,
//   //       selectedVariation: selectedAttributes.value,
//   //     );
//   //   } else if (attributeName == "size") {
//   //     AttreibuteValues attributes = AttreibuteValues(color: selectedAttributes.value.color, size: attributeValue);
//   //     selectedAttributes.value = attributes;
//   //     CartItemModel data = currentCartItem.value;
//   //     currentCartItem.value = CartItemModel(
//   //       productId: data.productId,
//   //       itemId: "${selectedAttributes.value.color}${selectedAttributes.value.size}",
//   //       title: data.title,
//   //       price: data.price,
//   //       image: data.image,
//   //       quantity: 0,
//   //       brandName: data.brandName,
//   //       selectedVariation: selectedAttributes.value,
//   //     );
//   //   }
//   // }

//   // set current cart item when the product details screen start
//   void _reSetCurrentCartItem() {
//     var data = ProductController.instance.currentProduct.value;
//     currentCartItem.value = CartItemModel(
//       productId: data.id,
//       itemId: data.productVariations.toString(),
//       title: data.title,
//       price: data.price,
//       image: data.images[0],
//       quantity: 0,
//       brandName: data.brand.name,
//       selectedVariation: defaultAttributesValues.value,
//     );
//   }

//   //set selected product variation & selected attributes
//   void _setInitData() {
//     selectedProductVariation.value = ProductController.instance.currentProduct.value.productVariations.first;
//     productColors.value = ProductController.instance.currentProduct.value.productAttributes[0].values;
//     productSizes.value = ProductController.instance.currentProduct.value.productAttributes[1].values;
//     defaultAttributesValues.value = selectedProductVariation.value.attributeValues!;
//     selectedAttributes.value = selectedProductVariation.value.attributeValues!;
//     _reSetCurrentCartItem();
//   }
// }
