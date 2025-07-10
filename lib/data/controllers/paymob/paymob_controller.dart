// import 'package:get/get.dart';

// import '../../../utils/helpers/network_manager.dart';
// import '../../../utils/popups/app_popups.dart';

// class PaymobController extends GetxController {
//   // instance creator
//   static PaymobController get instance => Get.find();

//   // Paymob API integration ID
//   final String integrationId = APIConstants.paymobIntegrationId;

//   //Cart controller
//   final orderController = Get.put(OrderController());

//   //webview controller
//   Rx<WebViewController?> webViewController = Rx<WebViewController?>(null);

//   //loader
//   RxBool loader = false.obs;

//   //http helper instance
//   HttpHelper httpHelper = HttpHelper(baseUrl: APIConstants.paymobBaseUrl);

//   RxString authToken = "".obs;
//   RxInt orderId = 0.obs;
//   RxString paymentKey = "".obs;

//   // Initialize variables if needed

//   void _initWebViewController() async {
//     webViewController.value = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onNavigationRequest: (request) async {
//             if (request.url.contains('success=true')) {
//               AppLogger.info('✅ success url: ${request.url}');
//               await orderController.commitSaveOrder().then((value) {
//                 AppLogger.info('✅ ${CartController.instance.cartItemsList.length.toString()}');
//               }).catchError((error) {
//                 AppLogger.error('❌ order save failed: $error');
//               });
//               Get.offAll(() => const PaymentSuccessScreen());
//               return NavigationDecision.prevent;
//             } else if (request.url.contains('success=fail')) {
//               Get.offAll(() => const PaymentFailureScreeen());
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(APIConstants.paymobIframeUrl + paymentKey.value));
//   }

//   // Step 1: Authenticate
//   Future<void> _authenticate() async {
//     final respons = await httpHelper.post(endpoint: APIConstants.paymobAuthUrl, data: {"api_key": APIConstants.paymobApiKey});

//     if (respons['success'] == true) {
//       authToken.value = respons['token'];
//       AppLogger.info('✅ Auth Token: $authToken');
//     } else {
//       AppLogger.error('❌ Auth Failed: ${respons['message'] ?? "error"}');
//       throw 'Authentication failed: ${respons['message'] ?? "error"}';
//     }
//   }

//   // Step 2: Create Order
//   Future<void> _createOrder({required int amountCents}) async {
//     if (authToken.isEmpty) await _authenticate();

//     final respons = await httpHelper.post(endpoint: APIConstants.paymobOrderUrl, data: {
//       "auth_token": authToken.value,
//       "delivery_needed": false,
//       "amount_cents": amountCents.toString(),
//       "currency": "EGP",
//       "items": [],
//       "shipping_data": {
//         "apartment": "NA",
//         "email": "test@example.com",
//         "floor": "NA",
//         "first_name": "Test",
//         "street": "Test Street",
//         "building": "NA",
//         "phone_number": "+201111111111",
//         "postal_code": "NA",
//         "city": "Cairo",
//         "country": "EG",
//         "last_name": "User",
//         "state": "Cairo"
//       }
//     });

//     if (respons['success'] == true) {
//       orderId.value = respons['id'];
//       AppLogger.info('✅ Order ID: $orderId');
//     } else {
//       AppLogger.error('❌ Order Failed: ${respons['message'] ?? "error"}');
//       throw 'Order creation failed: ${respons['message'] ?? "error"}';
//     }
//   }

//   // Step 3: Get Payment Key
//   Future<void> _getPaymentKey({required int amountCents}) async {
//     if (authToken.isEmpty || orderId.value == 0) {
//       AppLogger.warning('⚠️ You must authenticate and create order first');
//       return;
//     }

//     final response = await httpHelper.post(endpoint: APIConstants.paymobKeyUrl, data: {
//       "auth_token": authToken.value,
//       "amount_cents": amountCents.toString(),
//       "expiration": 3600,
//       "order_id": orderId.value,
//       "billing_data": {
//         "apartment": "NA",
//         "email": "test@example.com",
//         "floor": "NA",
//         "first_name": "Test",
//         "street": "Test Street",
//         "building": "NA",
//         "phone_number": "+201111111111",
//         "postal_code": "NA",
//         "city": "Cairo",
//         "country": "EG",
//         "last_name": "User",
//         "state": "Cairo"
//       },
//       "currency": "EGP",
//       "integration_id": integrationId
//     });

//     if (response['success'] == true) {
//       paymentKey.value = response['token'];
//       AppLogger.info('✅ Payment Key: $paymentKey');
//     } else {
//       AppLogger.error('❌ Payment Key Failed: ${response['message'] ?? "error"}');
//       throw 'Payment key creation failed: ${response['message'] ?? "error"}';
//     }
//   }

//   // Helper to run full flow
//   Future<void> makePayment(int amountCents) async {
//     try {
//       //check internet connection
//       final isConnected = await NetworkManager.instance.isNetworkConnection();
//       if (!isConnected) {
//         AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
//         return;
//       }
//       //start loading
//       loader.value = true;

//       //authenticate
//       await _authenticate();

//       //create order
//       await _createOrder(amountCents: amountCents);

//       //get payment key
//       await _getPaymentKey(amountCents: amountCents).then((value) {
//         _initWebViewController();
//       });

//       //stop loading
//       loader.value = false;
//     } catch (e) {
//       AppLogger.error('❌ Payment Process Failed: $e');
//       AppPopups.showErrorSnackBar(title: "payment process failed", message: e.toString());
//     } finally {
//       loader.value = false;
//     }
//   }
// }
