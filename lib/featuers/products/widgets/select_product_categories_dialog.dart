import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/containers/rounded_container.dart';
import 'package:ushop_web/common/widgets/dialogs/dialoges.dart';
import 'package:ushop_web/data/controllers/category/category_controller.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';

Future<dynamic> selectProductCategoriesDialog(
  BuildContext context,
) {
  final CategoryController categoryController = Get.put(CategoryController());
  final AddProductController addProductController = Get.find();
  return Dialoges.showFullScreenDialog(
    child: Obx(
      () => RoundedContainer(
        padding: const EdgeInsets.all(AppSizes.md),
        width: HelperFunctions.isDesktopScreen(context) ? 800 : 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Category",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            //space
            const SizedBox(height: AppSizes.md),
            Wrap(
              spacing: AppSizes.sm,
              runSpacing: AppSizes.sm,
              children: [
                ...List.generate(
                  categoryController.allCategories.length,
                  (index) => FilterChip(
                    label: Text(categoryController.allCategories[index].name),
                    selected: addProductController.isCategorySelected(categoryController.allCategories[index]),
                    onSelected: (value) {
                      // Handle the selection logic here
                      addProductController.onCategorySelected(categoryController.allCategories[index]);
                    },
                  ),
                ),
              ],
            ),
            //space
            const SizedBox(height: AppSizes.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Dialoges.hideCurrentDialog();
                  },
                  child: const Text("Close"),
                ),
                const SizedBox(width: AppSizes.sm),
                TextButton(
                  onPressed: () {
                    Dialoges.hideCurrentDialog();
                    // Handle the selection logic here
                    // For example, you can update the selected category in the product controller
                    // productController.setSelectedCategory(selectedCategory);
                  },
                  child: const Text("Select"),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
