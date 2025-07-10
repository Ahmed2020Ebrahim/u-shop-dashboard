import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialoges {
  static Future<dynamic> showDefaultDialog({required BuildContext context, required String title, Widget? contant, List<Widget>? actions}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox(width: 400, child: contant),
        actions: actions,
      ),
    );
  }

  static Future<dynamic> showFullScreenDialog({Widget? child}) async {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withValues(alpha: 0.3), // 30% transparent black background
          child: Center(
            child: child ?? const SizedBox(), // Loading spinner
          ),
        ),
      ),
      barrierDismissible: false, // Prevent closing by tapping outside
      barrierColor: Colors.transparent, // Let us control background manually
    );
  }

  static void hideCurrentDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back(); // Close the dialog
    }
  }
}
