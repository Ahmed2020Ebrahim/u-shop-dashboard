import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/images/custom_image.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import 'package:ushop_web/utils/validators/app_validators.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../../../data/models/image/image_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../media/controllers/media_controller.dart';
import '../controllers/add_product_controller.dart';

class ProductVariationExpansionTile extends StatelessWidget {
  const ProductVariationExpansionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final addProductController = Get.find<AddProductController>();
    final mediaController = Get.find<MediaController>();
    return ListView.builder(
      itemCount: addProductController.productVariatiosAttributesList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final variation = addProductController.productVariatiosAttributesList[index];
        final controllers = addProductController.variationControllersList[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: AppSizes.sm),
          child: Obx(() {
            return ExpansionTile(
              dense: true,
              collapsedBackgroundColor: AppColors.softGrey,
              backgroundColor: AppColors.softGrey.withValues(alpha: 0.8),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                side: const BorderSide(color: Colors.transparent, width: 0),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
                side: const BorderSide(color: Colors.transparent, width: 0),
              ),
              title: Text(addProductController.isUpdating.value ? variation["attributeValues"].toString() : variation.toString()),
              expandedAlignment: Alignment.topLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: const EdgeInsets.symmetric(vertical: AppSizes.sm, horizontal: AppSizes.sm),
              children: [
                RoundedContainer(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      //show image in state of the controller image is not empty
                      controllers.image.value.url.isNotEmpty
                          ? CustomImage(
                              imagePath: controllers.image.value.url,
                              fit: BoxFit.cover,
                              imageType: ImageType.network,
                              width: 100,
                              height: 100,
                            )
                          : const Icon(Iconsax.gallery, size: 100),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () async {
                            //open the media screen and chose image and set it to the current controller image
                            MediaController.instance.resetValues(true);
                            final data = await mediaController.showSelectProductImagesBottomSheet(
                              selectable: true,
                              multiSelectable: false,
                              folder: controllers.image.value.folder.isEmpty ? null : controllers.folder.value,
                              selectedImages: controllers.image.value.url.isEmpty ? null : [controllers.image.value],
                            );
                            if (data != null && data.isNotEmpty) {
                              controllers.image.value = data.first;
                              controllers.isImageSelected.value = true;
                              //set the folder of the controllers and check if the folder is null
                              controllers.folder.value =
                                  (data.first.mediaCategory.isEmpty ? MediaDropdownSectons.folders : HelperFunctions.getMediaDropdownSectonsFromString(data.first.mediaCategory))!;
                              controllers.folder.refresh();
                              addProductController.variationControllersList.refresh();
                            } else {
                              controllers.image.value = ImageModel.empty();
                              controllers.isImageSelected.value = false;
                              controllers.folder.value = MediaDropdownSectons.folders;
                            }
                            controllers.image.refresh();
                            controllers.isImageSelected.refresh();
                            addProductController.variationControllersList.refresh();
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.primary.withValues(alpha: 0.8),
                            child: const Icon(Iconsax.edit, color: AppColors.white, size: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                controllers.isImageSelected.value == false
                    ? Text(
                        'Please Select Image',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.error),
                      )
                    : const SizedBox(),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controllers.stockController,
                        validator: addProductController.stockValidator,
                        decoration: const InputDecoration(
                          labelText: "Stock",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      child: TextFormField(
                        controller: controllers.priceController,
                        validator: addProductController.pricesValidator,
                        decoration: const InputDecoration(
                          labelText: "Price",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      child: TextFormField(
                        controller: controllers.discountController,
                        validator: addProductController.pricesValidator,
                        decoration: const InputDecoration(
                          labelText: "Discounted Price",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.sm),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controllers.descriptionController,
                        validator: (value) {
                          return AppValidators.validateEmptyTextField("Description", value);
                        },
                        decoration: const InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
