import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';
import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/app_popups.dart';
import 'select_product_categories_dialog.dart';

class SelectProductCategoryField extends StatelessWidget {
  const SelectProductCategoryField({super.key});

  @override
  Widget build(BuildContext context) {
    final AddProductController addProductController = Get.find();

    return CustomeTiteledCard(
      title: "Category",
      child: Column(
        children: [
          //space
          const SizedBox(height: AppSizes.sm),
          InkWell(
            onTap: () {
              selectProductCategoriesDialog(context);
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Select Category', style: Theme.of(context).textTheme.labelSmall),
                    const Icon(Iconsax.arrow_down, color: AppColors.darkerGrey),
                  ],
                ),
                const Divider(color: AppColors.bgDark),
              ],
            ),
          ),
          //space
          Obx(
            () => addProductController.productCategoriesList.isEmpty
                ? const SizedBox()
                : Column(
                    children: [
                      const SizedBox(height: AppSizes.md),
                      Wrap(
                        spacing: AppSizes.sm,
                        runSpacing: AppSizes.sm,
                        children: [
                          ...addProductController.productCategoriesList.map(
                            (category) => Chip(
                              backgroundColor: AppColors.primary,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              label: Text(category.name, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white)),
                              padding: const EdgeInsets.all(AppSizes.sm),
                              deleteIcon: const Icon(Iconsax.close_circle),
                              onDeleted: () {
                                addProductController.onCategorySelected(category);
                                AppPopups.showSuccessToast(msg: "deleted from selected categories");
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
