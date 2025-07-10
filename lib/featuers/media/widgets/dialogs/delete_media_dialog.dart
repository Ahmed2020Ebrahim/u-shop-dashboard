import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/dialogs/dialoges.dart';
import '../../../../data/models/image/image_model.dart';
import '../../../../utils/constants/colors.dart';

Future<dynamic> deleteMediaDialog({required ImageModel deletedImage, required void Function()? onRemove}) {
  return Dialoges.showDefaultDialog(
    context: Get.context!,
    title: "Removal Confirmation",
    contant: const Text(
      'Are you sure you want to delete this Picture?',
      style: TextStyle(fontSize: 15, color: AppColors.darkerGrey),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text("Cancel"),
      ),
      TextButton(
        onPressed: onRemove,
        child: const Text("Remove"),
      ),
    ],
  );
}
