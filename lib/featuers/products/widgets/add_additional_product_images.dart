import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/images/custom_image.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';
import 'package:ushop_web/utils/constants/enums.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'additional_product_list_item.dart';

class AddAdditionalProductsImages extends StatelessWidget {
  const AddAdditionalProductsImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AddProductController addProductController = Get.find();
    return Obx(
      () {
        return CustomeTiteledCard(
          title: "Product Images",
          child: Container(
            height: 230,
            color: AppColors.white,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 120,
                  child: addProductController.activeAdditionalImage.value.url.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const RoundedContainer(
                              child: Icon(
                                Iconsax.gallery,
                                size: 70,
                              ),
                            ),
                            Text("Add Product Images", style: Theme.of(context).textTheme.labelMedium),
                          ],
                        )
                      : CustomImage(
                          imagePath: addProductController.activeAdditionalImage.value.url,
                          width: 120,
                          height: 120,
                          imageType: ImageType.network,
                        ),
                ),
                RoundedContainer(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
                  color: AppColors.softGrey,
                  height: addProductController.productAdditionalImages.isEmpty ? 70 : 70 + 35, // Extra space for "Remove" button
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 5/6 for the horizontal list
                      Expanded(
                        flex: 10,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          itemCount: addProductController.productAdditionalImages.isEmpty ? 10 : addProductController.productAdditionalImages.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 4),
                          itemBuilder: (context, index) => addProductController.productAdditionalImages.isEmpty
                              ? Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: Alignment.center,
                                )
                              : AdditionalProductListItem(
                                  imagePath: addProductController.productAdditionalImages[index].url,
                                  onTap: () {
                                    addProductController.changeActiveAdditionalImage(addProductController.productAdditionalImages[index].id);
                                  },
                                  onRemove: () {
                                    addProductController.removeSelectedAditionalImage(addProductController.productAdditionalImages[index].id);
                                  },
                                  isActive: addProductController.activeAdditionalImage.value.id == addProductController.productAdditionalImages[index].id,
                                ),
                        ),
                      ),

                      // 1/6 for the add button
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              // Handle add logic
                              await addProductController.selectAdditionalImages();
                            },
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Icon(Icons.add, color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
