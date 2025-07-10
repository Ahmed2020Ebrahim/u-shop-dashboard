import 'package:get/get.dart';
import 'package:ushop_web/bindings/brand/brand_binding.dart';
import 'package:ushop_web/bindings/order/order_binding.dart';
import 'package:ushop_web/bindings/product/product_binding.dart';
import 'package:ushop_web/common/screens/loading_screen.dart';
import 'package:ushop_web/featuers/authentication/login/views/await_email_verification/screens/await_verification_screen.dart';
import 'package:ushop_web/featuers/authentication/login/views/forget_password_view/screens/forget_password_screen.dart';
import 'package:ushop_web/featuers/authentication/login/views/login_view/screens/login_screen.dart';
import 'package:ushop_web/middleware/auth_middleware.dart';
import '../featuers/dashboard/dashboard_content_view/dashboard_content_view.dart';

class AppRouts {
  static const String responsiveScreen = "/";
  static const String login = "/login";
  static const String dashboard = "/dashboard";
  static const String media = "/media";

  static const String bannars = "/bannars";
  static const String addBanner = "/bannars/addBanner";
  static const String editBanner = "/bannars/editBanner";

  static const String products = "/products";
  static const String addProduct = "/products/addProduct";
  static const String updateProduct = "/products/updateProduct";

  static const String categories = "/categories";
  static const String addCategory = "/categories/addCategory";
  static const String updateCategory = "/categories/updateCategory";

  static const String brands = "/brands";
  static const String addBrand = "/brands/addBrand";
  static const String editBrand = "/brands/editBrand";

  static const String customers = "/customers";
  static const String customerDetails = "/customers/customerDetails";

  static const String orders = "/orders";
  static const String orderDetails = "/orderDetails";

  static const String coupons = "/coupons";
  static const String settings = "/settings";
  static const String profile = "/profile";
  static const String logout = "/logout";

  static const String loadingScreen = "/loading";
  static const String forgetPassword = "/forgetPassword";
  static const String awaitEmailVerify = "/awaitEmailVerify";

  static const List<String> sideBarItemsRouts = [dashboard, media, bannars, products, categories, brands, customers, orders, coupons, settings, logout];
  // static const String secondScreen = "/secondScreen";
  // static const String secondScreenWithUserId = "/secondScreen/:userId";

  static List<GetPage<dynamic>> getPages = [
    //loding screen
    GetPage(name: loadingScreen, page: () => const LoadingScreen()),
    //login screen
    GetPage(name: login, page: () => const LoginScreen(), middlewares: [AuthMiddleware()], bindings: [ProductBinding()]),
    //forget password screen
    GetPage(name: forgetPassword, page: () => const ForgetPasswordScreen()),
    //await email verification screen
    GetPage(name: awaitEmailVerify, page: () => const AwaitVerificationScreen()),
    //dashboard screen
    GetPage(name: dashboard, page: () => const DashboardContentView(), middlewares: [AuthMiddleware()], bindings: [ProductBinding()]),
    //media screen
    GetPage(name: media, page: () => const DashboardContentView()),
    //bannars screen
    GetPage(name: bannars, page: () => const DashboardContentView()),

    //**********products screen & its sub screens******************//
    //product screen
    GetPage(name: products, page: () => const DashboardContentView()),
    //add product screen
    GetPage(name: addProduct, page: () => const DashboardContentView()),

    //******************************* */
    //categories screen
    GetPage(name: categories, page: () => const DashboardContentView()),
    //brands screen
    GetPage(name: brands, page: () => const DashboardContentView(), bindings: [BrandBinding()]),
    //customers screen
    GetPage(name: customers, page: () => const DashboardContentView()),
    //orders screen
    GetPage(name: orders, page: () => const DashboardContentView(), bindings: [OrderBinding()]),
    //coupons screen
    GetPage(name: coupons, page: () => const DashboardContentView()),
    //settings screen
    GetPage(name: settings, page: () => const DashboardContentView()),
    //logout screen
    GetPage(name: logout, page: () => const LoginScreen()),
  ];
}
