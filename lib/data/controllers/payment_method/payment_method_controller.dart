// import 'package:get/get.dart';
// import 'package:ushop/utils/constants/images.dart';

// class PaymentMethodsController extends GetxController {
//   //instance creator
//   static PaymentMethodsController get instance => Get.find();

//   //selected payment method
//   RxMap selectedPaymentMethod = <String, String>{"name": "MasterCard", "image": AppImages.masterCard}.obs;

//   //payment methods
//   final List<Map<String, String>> _paymentMethods = [
//     {"name": "PayMob", "image": AppImages.payMob},
//     {"name": "PayPal", "image": AppImages.paypal},
//     {"name": "MasterCard", "image": AppImages.masterCard},
//     {"name": "GooglePay", "image": AppImages.googlePay},
//     {"name": "ApplePay", "image": AppImages.applePay},
//     {"name": "PayStack", "image": AppImages.payStack},
//     {"name": "Visa", "image": AppImages.visa},
//     {"name": "Credit Card", "image": AppImages.creditCard},
//   ];

//   //get payment methods
//   List<Map<String, String>> get paymentMethods {
//     return _paymentMethods;
//   }

//   //on payment method selected
//   void onPaymentMethodSelected(String paymentName, String paymentImage) {
//     selectedPaymentMethod.value = <String, String>{"name": paymentName, "image": paymentImage};
//   }
// }
