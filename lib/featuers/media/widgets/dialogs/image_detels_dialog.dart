import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ushop_web/utils/popups/app_popups.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/dialogs/dialoges.dart';
import '../../../../common/widgets/images/custom_image.dart';
import '../../../../data/models/image/image_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/media_controller.dart';

Future<dynamic> imageDetailsDialgo(BuildContext context, ImageModel image) {
  final controller = Get.put(MediaController());
  return Dialoges.showFullScreenDialog(
    child: RoundedContainer(
      width: HelperFunctions.isMobileScreen(context) ? 340 : 500,
      height: HelperFunctions.isMobileScreen(context) ? 450 : 500,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                        child: CustomImage(
                          imagePath: image.url,
                          width: double.infinity,
                          height: HelperFunctions.isMobileScreen(context) ? 250 : 300,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      const Divider(),
                      const SizedBox(height: AppSizes.sm),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const FittedBox(
                                        child: Text(
                                          "Image Name :",
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                      FittedBox(child: Text(image.fileName)),
                                      const SizedBox(width: AppSizes.sm),
                                    ],
                                  ),
                                  const SizedBox(height: AppSizes.sm),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Image Url :"),
                                      SizedBox(
                                        width: HelperFunctions.isMobileScreen(context) ? 100 : 200,
                                        child: Text(
                                          image.url,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis, // or .fade / .clip
                                          softWrap: false,
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(text: image.url));
                                          AppPopups.showSuccessToast(msg: "Url Copied");
                                        },
                                        child: const Text("Copy Url"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.cancel, color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Align(
              alignment: Alignment.bottomCenter,
              child: Obx(
                () => controller.isDeleting.value
                    ? const CircularProgressIndicator(
                        color: AppColors.error,
                      )
                    : TextButton(
                        onPressed: () {
                          controller.deletImage(image);
                        },
                        child: const Text(
                          "Delet Image",
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
