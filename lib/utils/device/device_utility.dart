import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppDeviceUtilies {
  AppDeviceUtilies._();

//! ---> hide keyboard
  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

//! ---> set statusbar color
  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );
  }

//! ---> is landscape oriantation
  static bool isLandscapeOriantation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

//! ---> is portrait oriantation
  static bool isPortraitOriantation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

//! ---> set full screen
  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

//! ---> get screen height
  static double getScreenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

//! ---> get screen width
  static double getScreenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

//! ---> get pixel ratio
  static double getPixelRatio() {
    return MediaQuery.of(Get.context!).devicePixelRatio;
  }

//! ---> get status bar height
  static double getStatusBarHeight() {
    return MediaQuery.of(Get.context!).padding.top;
  }

// //! ---> get Bottom Navigation Bar Height
//   static double getBottomNavigationBarHeight() {
//     return AppBottomNavigationBarHeight;
//   }

// //! ---> get App Bar Height
//   static double getAppBarHeight() {
//     return AppBarHeight;
//   }

//! ---> get Keyboard Height
  static double getKeyboardHeight() {
    final viewInstes = View.of(Get.context!).viewInsets;
    return viewInstes.bottom;
  }

//! ---> is keyboard visable
  static Future<bool> isKeyBoardVisable() async {
    final viewInstes = View.of(Get.context!).viewInsets;
    return viewInstes.bottom > 0;
  }

//! ---> is physical device
  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

//! ---> vibrate
  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

//! ---> set preferred oriantations
  static Future<void> setPreferredOriantations(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

//! ---> hide statusBar
  static void hideStatusBar() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

//! ---> show statusBar
  static void showStatusBar() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

//! ---> has Internet connection
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup("example.come");
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

//! ---> isIos
  static bool isIos() {
    return Platform.isIOS;
  }

//! ---> has InterNet connection
  static bool isAndroid() {
    return Platform.isAndroid;
  }

//! ---> launch url
  static void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
