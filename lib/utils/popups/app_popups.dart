import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/toasts/toasts.dart';
import '../../common/widgets/snackbars/snackbars.dart';

class AppPopups {
  AppPopups._();

  //fullscreen loader

  //show cancel full screen

  //warning snackbar
  static void showWarningSnackBar({required String title, required String message}) {
    SnackBars.warningSnackBar(title: title, message: message);
  }

  //error snackbar
  static void showErrorSnackBar({required String title, required String message}) {
    SnackBars.errorSnackBar(title: title, message: message);
  }

  //success snackbar
  static void showSuccessSnackBar({required String title, required String message}) {
    SnackBars.successSnackBar(title: title, message: message);
  }

  // stop loading
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }

  //success toast
  static Future<bool?> showSuccessToast({required String msg}) {
    return Toasts.successToast(msg: msg);
  }

  //success toast
  static Future<bool?> showInfoToast({required String msg}) {
    return Toasts.infoToast(msg: msg);
  }

  //success toast
  static Future<bool?> showWarningToast({required String msg}) {
    return Toasts.warningToast(msg: msg);
  }

  //success toast
  static Future<bool?> showErrorToast({required String msg}) {
    return Toasts.errorToast(msg: msg);
  }
}
