import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/dialogs/dialoges.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/texts.dart';

Future<dynamic> uploadImageConfirmationDialog({required Function()? onConfirm}) {
  return Dialoges.showDefaultDialog(
    context: Get.context!,
    title: AppTexts.uploadImageConfirmationTitle,
    contant: const Text(AppTexts.uploadImageConfirmationMessage),
    actions: [
      TextButton(
        style: TextButton.styleFrom(padding: const EdgeInsets.fromLTRB(5, 4, 5, 4)),
        onPressed: () {
          Get.back();
        },
        child: const Text(
          "Cancel",
          style: TextStyle(color: AppColors.error, fontSize: 18),
        ),
      ),
      SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.fromLTRB(5, 4, 5, 4), backgroundColor: AppColors.primary),
          onPressed: onConfirm,
          child: const Text("Confirm"),
        ),
      ),
    ],
  );
}
