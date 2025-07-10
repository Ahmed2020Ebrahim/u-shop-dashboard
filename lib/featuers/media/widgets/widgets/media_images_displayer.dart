import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/featuers/media/controllers/media_controller.dart';
import 'package:ushop_web/utils/constants/app_images.dart';
import '../../../../common/widgets/buttons/app_primary_button.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import 'media_image_button.dart';

class MediaImageDisplayer extends StatelessWidget {
  const MediaImageDisplayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaController mediaController = Get.find();
    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Obx(
        () => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Gallary Folders", style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: AppSizes.md),
                    SizedBox(
                      width: 150,
                      child: DropdownButtonFormField(
                        borderRadius: BorderRadius.circular(20),
                        value: mediaController.currentFolder.value,
                        isExpanded: false,
                        items: MediaDropdownSectons.values
                            .map(
                              (e) => DropdownMenuItem(
                                onTap: () {},
                                value: e,
                                child: Text(
                                  HelperFunctions.capitalizeFirst(e.name),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) async {
                          await mediaController.fetchImagesFromDatabase(value!);
                        },
                      ),
                    ),
                    mediaController.isSelectable.value && mediaController.currentSelectedImages.isNotEmpty ? const SizedBox(width: AppSizes.lg) : const SizedBox(),
                    mediaController.isSelectable.value && mediaController.currentSelectedImages.isNotEmpty
                        ? AppPrimaryButton(
                            onTap: () {
                              mediaController.backWithSelectedImages();
                            },
                            label: "Done",
                            icon: const Icon(
                              Icons.check,
                              color: AppColors.white,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSizes.md),
            Row(
              children: [
                Expanded(
                  child: mediaController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : mediaController.currentFolderList.isEmpty || mediaController.currentFolder.value == MediaDropdownSectons.folders
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    AppImages.emptyBox,
                                    width: 300,
                                    height: 300,
                                    repeat: true,
                                    reverse: false,
                                    animate: true,
                                  ),
                                  const Text("Select Folder"),
                                ],
                              ),
                            )
                          : Wrap(
                              spacing: AppSizes.sm,
                              runSpacing: AppSizes.sm,
                              children: [
                                ...mediaController.currentFolderList.map(
                                  (element) => MediaImageButton(
                                    isSelectable: mediaController.isSelectable.value,
                                    isSelected: element.isSelected.value,
                                    onSelectedChange: (value) {
                                      mediaController.onSelectedChange(element.id);
                                      mediaController.currentSelectedImages.refresh();
                                    },
                                    imagePath: element.url,
                                    onTap: () {
                                      //showImageDetailsDialog
                                      mediaController.showImageDetailsDialog(element, context);
                                    },
                                    isMemory: false,
                                  ),
                                )
                              ],
                            ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.lg),
            mediaController.currentFolderList.isEmpty
                ? const SizedBox()
                : HelperFunctions.isMobileScreen(context)
                    ? SizedBox(
                        width: double.infinity,
                        child: AppPrimaryButton(
                            onTap: () async {
                              await mediaController.loadMoreImages(mediaController.currentFolder.value);
                            },
                            label: "Load more",
                            icon: const Icon(
                              Iconsax.arrow_down,
                              color: AppColors.white,
                            )),
                      )
                    : SizedBox(
                        width: 170,
                        child: AppPrimaryButton(
                          onTap: () async {
                            await mediaController.loadMoreImages(mediaController.currentFolder.value);
                          },
                          label: "Load more",
                          icon: const Icon(
                            Iconsax.arrow_down,
                            color: AppColors.white,
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}



// Wrap(
//                               spacing: AppSizes.sm,
//                               runSpacing: AppSizes.sm,
//                               children: [
//                                 ...mediaController.currentFolderList.map(
//                                   (element) => MediaImageButton(
//                                     imagePath: element.url,
//                                     onTap: () {
//                                       //showImageDetailsDialog
//                                       mediaController.showImageDetailsDialog(element, context);
//                                     },
//                                     isMemory: false,
//                                   ),
//                                 )
//                               ],
//                             ),