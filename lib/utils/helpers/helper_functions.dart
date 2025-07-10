import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:uuid/uuid.dart';

import '../constants/app_images.dart';
import '../constants/colors.dart';
import '../constants/enums.dart';

class HelperFunctions {
  HelperFunctions._();

//! ---> get random order status
  static OrderStatus getRandomStatus() {
    final random = Random();
    const statuses = OrderStatus.values;
    return statuses[random.nextInt(statuses.length)];
  }

//! ---> get week start day
  static DateTime getWeekStartDay(DateTime date) {
    final DateTime currentTime = DateTime(2025, 5, 29);
    final int daysUntilMonday = currentTime.weekday - 1;
    final DateTime startOfWeek = currentTime.subtract(Duration(days: daysUntilMonday));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day, 0, 0, 0, 0, 0);
  }

//! ---> show snack Bar
  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

//! ---> show alert
  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

//! ---> random past data
  static //!method that creat a randome past date
      DateTime getRandomPastDate({int maxYearsAgo = 2}) {
    final random = Random();

    // Generate a random number of days up to (maxYearsAgo * 365)
    int daysAgo = random.nextInt(maxYearsAgo * 365);

    // Subtract that many days from the current date
    return DateTime.now().subtract(Duration(days: daysAgo));
  }

//! ---> navigate to screen
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

//! ---> generate id
//! ---> generate uid
  static String generateId() {
    var uuid = const Uuid();
    String id = uuid.v4();
    return id;
  }

//! ---> truncate Text
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return "${text.substring(0, maxLength)}...";
    }
  }

//! ---> is dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

//! ---> get screen size
  static Size getScreenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double getScreenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

//! ---> get screen width
  static double getScreenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

//! ---> get formated date
  static String getFormattedDate(DateTime date, {String format = "dd MMM yyy"}) {
    return DateFormat(format).format(date);
  }

//! ---> capitalizeFirst
  static String capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

//! ---> remove dublicates
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

//! ---> is desktop screen
  static bool isDesktopScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppSizes.desktopScreen;
  }

//! ---> is desktop screen
  static bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < AppSizes.desktopScreen && MediaQuery.of(context).size.width >= AppSizes.tabletScreen;
  }

//! ---> is desktop screen
  static bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < AppSizes.tabletScreen;
  }

//! ---> genereate sku
  static String generateSkuFromAttributes(Map<String, String> attributes) {
    return attributes.entries.map((e) => '${e.key.substring(0, 2).toUpperCase()}${e.value.substring(0, 2).toUpperCase()}').join('-');
  }

//! ---> return medadropdown
  static MediaDropdownSectons? getMediaDropdownSectonsFromString(String value) {
    return MediaDropdownSectons.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MediaDropdownSectons.folders,
    );
  }

//! ---> return orderstatus
  static OrderStatus? getOrderStatusFromString(String value) {
    return OrderStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => OrderStatus.pending,
    );
  }

//! ---> return BannerActivationPathes
  static BannerActivationPathes? getBannerActivationPathesFromString(String value) {
    return BannerActivationPathes.values.firstWhere(
      (e) => e.name == value,
      orElse: () => BannerActivationPathes.selectPath,
    );
  }

//! ---> return productType form string
  static ProductType? getProductTypeFromString(String value) {
    return ProductType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ProductType.single,
    );
  }

//! ---> return productVisibilty from String
  static ProductVisibility? getProductVisibilityFromString(String value) {
    return ProductVisibility.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ProductVisibility.published,
    );
  }

//! ---> return paymentmethod
  static PaymentMethods? getPaymentMethodFromString(String value) {
    //convert the first letter only to the lower case
    value = value.substring(0, 1).toLowerCase() + value.substring(1);
    return PaymentMethods.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PaymentMethods.payPal,
    );
  }

//! ---> get payment method image path acording to paymentmethod
  static String getPaymentMethodImage(PaymentMethods? paymentMethod) {
    switch (paymentMethod) {
      case PaymentMethods.payMob:
        return AppImages.paymob;
      case PaymentMethods.payPal:
        return AppImages.paypal;
      case PaymentMethods.masterCard:
        return AppImages.masterCard;
      case PaymentMethods.googlePay:
        return AppImages.googlePay;
      case PaymentMethods.applePay:
        return AppImages.applePay;
      case PaymentMethods.payStack:
        return AppImages.payStack;
      case PaymentMethods.visa:
        return AppImages.visa;
      case PaymentMethods.creditCard:
        return AppImages.cridetCard;
      default:
        return AppImages.paypal;
    }
  }

//! ---> get payment fee according to pyment method
  static double getPaymentFee(PaymentMethods? paymentMethod) {
    switch (paymentMethod) {
      case PaymentMethods.payMob:
        return 3.5;
      case PaymentMethods.payPal:
        return 4.4;
      case PaymentMethods.masterCard:
        return 2.9;
      case PaymentMethods.googlePay:
        return 2.9;
      case PaymentMethods.applePay:
        return 2.9;
      case PaymentMethods.payStack:
        return 3.9;
      case PaymentMethods.visa:
        return 2.9;
      case PaymentMethods.creditCard:
        return 3.5;
      default:
        return 2.5;
    }
  }

  //! ---> get order color
  static Color getOrderColor(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.processing:
        return AppColors.processingOrderColor;
      case OrderStatus.shipped:
        return AppColors.shippedOrderColor;
      case OrderStatus.delivered:
        return AppColors.deliveredOrderColor;
      case OrderStatus.cancelled:
        return AppColors.cancelledOrderColor;
      case OrderStatus.pending:
        return AppColors.pendingOrderColor;
    }
  }
}
