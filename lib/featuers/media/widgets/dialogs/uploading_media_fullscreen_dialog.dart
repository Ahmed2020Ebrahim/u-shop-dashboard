import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/dialogs/dialoges.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/media_controller.dart';

Future<dynamic> upladingMediaFullScreenDialog(MediaController controller) {
  return Dialoges.showFullScreenDialog(
    child: RoundedContainer(
      color: AppColors.white,
      width: 250,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(AppImages.uploading1, animate: true, width: 200, height: 200, repeat: true),
          const SizedBox(height: AppSizes.sm),
          const Text("Uploading Images.....", style: TextStyle(fontWeight: FontWeight.normal, color: AppColors.darkerGrey)),
          const SizedBox(height: AppSizes.sm),
          Obx(
            () => Text("${controller.selectedImageToUpload.length} images left"),
          )
        ],
      ),
    ),
  );
}
