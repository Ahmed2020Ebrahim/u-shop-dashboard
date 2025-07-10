import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/cards/custome_titled_card.dart';
import 'package:ushop_web/common/widgets/images/custom_image.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class AddProductThumbnile extends StatelessWidget {
  const AddProductThumbnile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AddProductController addProductController = Get.find();

    return CustomeTiteledCard(
      title: "Product Thumbnile",
      child: RoundedContainer(
        padding: const EdgeInsets.all(AppSizes.md),
        color: AppColors.softGrey,
        width: double.infinity,
        child: Column(
          children: [
            Obx(
              () => addProductController.productThumbnail.value.url.isEmpty
                  ? const Icon(Iconsax.gallery, size: 120)
                  : CustomImage(
                      imagePath: addProductController.productThumbnail.value.url,
                      fit: BoxFit.fill,
                      width: 120,
                      height: 120,
                    ),
            ),
            const SizedBox(height: AppSizes.sm),
            InkWell(
              onTap: () async {
                await addProductController.selectThumbnile();
              },
              child: RoundedContainer(
                color: AppColors.grey,
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: 2),
                child: Obx(
                  () => Text(
                    addProductController.productThumbnail.value.url.isNotEmpty ? 'Change Thumbnile' : 'Add Thumbnile',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
