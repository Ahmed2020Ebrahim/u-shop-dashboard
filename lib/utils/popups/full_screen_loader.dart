import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/utils/constants/colors.dart';

class FullScreenLoader {
  //open full screen loader
  static open(String message, String animation) {
    showDialog(
      context: Get.overlayContext!,
      builder: (_) => PopScope(
        canPop: false,
        child: Scaffold(
          body: Container(
            height: Get.height,
            color: AppColors.white.withValues(alpha: 0.5),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: Get.height / 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(),
                Center(
                  child: Lottie.asset(
                    animation,
                    width: 300,
                    repeat: true,
                    reverse: false,
                    animate: true,
                  ),
                ),
                Text(message, style: const TextStyle(letterSpacing: 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //close the loader screen
  static close() {
    Navigator.of(Get.context!).pop();
  }
}
