import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../../../common/widgets/images/custom_image.dart';
import '../../../data/controllers/user/user_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/logging/app_logger.dart';
import '../controllers/profile_controller.dart';

class ProfileImageCard extends StatelessWidget {
  const ProfileImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.put(UserController());
    final ProfileController profileController = Get.put(ProfileController());

    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.md),
      width: double.infinity,
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => Stack(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: DropzoneView(
                    mime: const ["image/png", "image/jpeg", "image/jpg"],
                    onCreated: (controller) {
                      profileController.dropzoneViewController = controller;
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
                profileController.userImage.value.isEmpty
                    ? const CircleAvatar(
                        radius: 60,
                        child: Icon(Iconsax.user, size: 60),
                      )
                    : profileController.selectedImageToUpload.isNotEmpty
                        ? ClipOval(
                            child: Image.memory(
                              profileController.selectedImageToUpload.first.localImageToUpdate!,
                              fit: BoxFit.fill,
                              width: 120,
                              height: 120,
                            ),
                          )
                        : CustomImage(
                            imagePath: profileController.userImage.value,
                            isCircular: true,
                            imageType: ImageType.network,
                            fit: BoxFit.fill,
                            width: 120,
                            height: 120,
                          ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () async {
                      await profileController.selectProfileImage();
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary.withValues(alpha: 0.8),
                      radius: 20,
                      child: const Icon(
                        Iconsax.edit,
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
          Text(controller.currentUser.value.userName, style: Theme.of(context).textTheme.titleLarge),
          Text(controller.currentUser.value.email, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
