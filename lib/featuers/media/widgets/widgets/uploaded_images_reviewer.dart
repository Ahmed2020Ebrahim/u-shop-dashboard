import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/featuers/media/controllers/media_controller.dart';
import '../../../../common/widgets/buttons/app_primary_button.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import 'media_image_button.dart';

class UploadedImagesReviewer extends StatelessWidget {
  const UploadedImagesReviewer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final MediaController mediaController = Get.find();
    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Select Folder", style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(width: AppSizes.md),
                  SizedBox(
                    width: 150,
                    child: Obx(
                      () => DropdownButtonFormField(
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
                  ),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      mediaController.onRemoveAll();
                    },
                    child: const Text("Remove All"),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  HelperFunctions.isMobileScreen(context)
                      ? const SizedBox()
                      : SizedBox(
                          width: 100,
                          child: AppPrimaryButton(
                            label: "Upload",
                            onTap: () {
                              mediaController.showUploadImagesConfirmationDialog();
                            },
                          ),
                        ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: AppSizes.sm,
                    runSpacing: AppSizes.sm,
                    children: [
                      ...mediaController.selectedImageToUpload.map(
                        (element) => MediaImageButton(
                          memoryImage: element.localImageToUpdate!,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          HelperFunctions.isMobileScreen(context)
              ? SizedBox(
                  width: double.infinity,
                  child: AppPrimaryButton(
                    label: "Upload",
                    onTap: () {},
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
