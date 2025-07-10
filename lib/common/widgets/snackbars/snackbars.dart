import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';

class SnackBars {
  // warning snackbar
  static warningSnackBar({required String title, required String message}) {
    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: AppColors.white),
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        snackBarAnimationStyle: AnimationStyle(curve: Curves.easeInOut, duration: const Duration(milliseconds: 300)),
      );
  }

  // error snackbar
  static errorSnackBar({required String title, required String message}) {
    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: AppColors.white),
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        snackBarAnimationStyle: AnimationStyle(curve: Curves.easeInOut, duration: const Duration(milliseconds: 300)),
      );
  }

  // success snackbar
  static successSnackBar({required String title, required String message}) {
    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: AppColors.white),
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        snackBarAnimationStyle: AnimationStyle(curve: Curves.easeInOut, duration: const Duration(milliseconds: 300)),
      );
  }
}
