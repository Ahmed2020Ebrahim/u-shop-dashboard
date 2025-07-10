import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/images/custom_image.dart';
import 'package:ushop_web/featuers/settings/controllers/settings_controller.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/logging/app_logger.dart';

class AppImageSettings extends StatelessWidget {
  const AppImageSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.put(SettingsController());
    return Obx(
      () => RoundedContainer(
        padding: const EdgeInsets.all(AppSizes.md),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoundedContainer(
              width: 200,
              height: 200,
              color: AppColors.softGrey,
              padding: const EdgeInsets.all(AppSizes.sm),
              child: Stack(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: DropzoneView(
                      mime: const ["image/png", "image/jpeg", "image/jpg"],
                      onCreated: (controller) {
                        settingsController.dropzoneViewController = controller;
                      },
                      cursor: CursorType.Default,
                      onDropFile: (file) {},
                      onDropFiles: (files) {},
                      operation: DragOperation.copy,
                      onDropInvalid: (value) {},
                      onError: (value) {
                        AppLogger.error("on drag and drop error");
                      },
                      onHover: () {
                        AppLogger.error("on drag and drop hover");
                      },
                      onLeave: () {
                        AppLogger.error("on drag and drop leave");
                      },
                      onLoaded: () {
                        AppLogger.error("on drag and drop loaded");
                      },
                    ),
                  ),
                  RoundedContainer(
                    color: AppColors.softGrey,
                    width: double.infinity,
                    height: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: settingsController.selectedImageToUpload.isEmpty
                          ? settingsController.appImage.value.isEmpty
                              ? const Icon(Iconsax.gallery)
                              : CustomImage(
                                  imagePath: settingsController.appImage.value,
                                  isCircular: true,
                                  imageType: ImageType.network,
                                  fit: BoxFit.fill,
                                  width: 120,
                                  height: 120,
                                  borderRadius: BorderRadius.circular(8),
                                )
                          : ClipOval(
                              child: Image.memory(
                                settingsController.selectedImageToUpload.first.localImageToUpdate!,
                                fit: BoxFit.fill,
                                width: 120,
                                height: 120,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        await settingsController.selectAppImage();
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary.withValues(alpha: 0.8),
                        radius: 20,
                        child: const Icon(
                          Iconsax.setting,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: AppSizes.md),
            Text("My App", style: Theme.of(context).textTheme.titleLarge)
          ],
        ),
      ),
    );
  }
}
