import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/buttons/app_primary_button.dart';
import '../../../../utils/constants/colors.dart';
import '../../controllers/media_controller.dart';

class UploadImagesButton extends StatelessWidget {
  const UploadImagesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaController mediaController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 175,
          alignment: Alignment.centerRight,
          child: AppPrimaryButton(
            label: "Upload Images",
            icon: const Icon(
              Iconsax.cloud_add,
              color: AppColors.white,
            ),
            onTap: () {
              mediaController.changeDrageZoneState();
            },
          ),
        ),
      ],
    );
  }
}
