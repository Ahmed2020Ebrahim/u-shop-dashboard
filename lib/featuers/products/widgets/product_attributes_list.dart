import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/cards/custome_titled_card.dart';
import 'package:ushop_web/common/widgets/containers/rounded_container.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

import 'creat_variation_button.dart';

class ProductAttributesList extends StatelessWidget {
  const ProductAttributesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AddProductController addProductController = Get.find();
    return CustomeTiteledCard(
      padding: const EdgeInsets.all(AppSizes.md),
      title: "All Attributes",
      child: Obx(
        () => Column(
          children: [
            const SizedBox(height: AppSizes.md),
            RoundedContainer(
              padding: const EdgeInsets.all(AppSizes.md),
              color: AppColors.softGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: addProductController.productAttributesList.isNotEmpty
                    ? addProductController.productAttributesList
                        .map(
                          (element) => RoundedContainer(
                            margin: const EdgeInsets.only(bottom: AppSizes.sm),
                            color: AppColors.white,
                            child: ListTile(
                              tileColor: AppColors.white,
                              title: Text(
                                element.name,
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                              ),
                              subtitle: Text(
                                addProductController.separetAttributesValues(element.values),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  addProductController.deletAttribute(element.id);
                                },
                                icon: const Icon(Iconsax.trash, color: AppColors.error),
                              ),
                            ),
                          ),
                        )
                        .toList()
                    : [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...List.generate(
                                  AppColors.attributeColors.length,
                                  (index) => Container(
                                    height: AppSizes.md,
                                    width: AppSizes.md,
                                    color: AppColors.attributeColors[index],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSizes.md),
                            Text(
                              "There Are No Attributes Added Yet",
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.textSecondary),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
              ),
            ),
            if (addProductController.productType.value == ProductType.variable) const CreatVariationsButton(),
          ],
        ),
      ),
    );
  }
}
