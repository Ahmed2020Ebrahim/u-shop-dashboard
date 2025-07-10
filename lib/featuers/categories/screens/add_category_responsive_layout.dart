import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/buttons/app_primary_button.dart';
import 'package:ushop_web/common/widgets/cards/custome_titled_card.dart';
import 'package:ushop_web/common/widgets/containers/rounded_container.dart';
import 'package:ushop_web/data/controllers/category/category_controller.dart';
import 'package:ushop_web/data/models/category/category_model.dart';
import 'package:ushop_web/featuers/categories/controllers/add_category_controller.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';
import 'package:ushop_web/utils/validators/app_validators.dart';

import '../../../common/widgets/images/custom_image.dart';
import '../../../utils/constants/enums.dart';

class AddCategoryResponsiveLayout extends StatelessWidget {
  const AddCategoryResponsiveLayout({super.key, this.updatedCategory});

  final CategoryModel? updatedCategory;

  @override
  Widget build(BuildContext context) {
    //category  instace
    final CategoryController categoryController = Get.find();
    final AddCategoryController addCategoryController = Get.put(AddCategoryController());

    //media controller

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.md),
            Obx(
              () => RoundedContainer(
                width: HelperFunctions.isDesktopScreen(context) ? 400 : null,
                child: CustomeTiteledCard(
                  title: addCategoryController.isUpdate.value ? "Update Category" : "Create New category",
                  child: Column(
                    children: [
                      const SizedBox(height: AppSizes.md),
                      Form(
                        key: addCategoryController.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              validator: (value) => AppValidators.validateEmptyTextField("name", value),
                              controller: addCategoryController.nameController,
                              decoration: const InputDecoration(
                                labelText: "Category Name",
                                prefixIcon: Icon(Iconsax.category),
                              ),
                            ),
                            const SizedBox(height: AppSizes.spaceBtwInputFields),
                            DropDownTextField(
                              validator: (value) => AppValidators.validateEmptyTextField("parent category", value),
                              textFieldDecoration: const InputDecoration(
                                labelText: "Parent Category",
                                prefixIcon: Icon(Iconsax.category),
                              ),
                              enableSearch: true,
                              dropDownList: [
                                ...categoryController.allCategories.map(
                                  (category) => DropDownValueModel(
                                    name: category.name,
                                    value: category,
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                final selectedCategory = value?.value as CategoryModel?;
                                if (value != null) {
                                  addCategoryController.setParentCategory(selectedCategory!.parentId);
                                }
                              },
                              dropDownIconProperty: IconProperty(
                                icon: Iconsax.box,
                                color: AppColors.darkerGrey,
                                size: 30,
                              ),
                            ),
                            const SizedBox(height: AppSizes.spaceBtwInputFields),
                            RoundedContainer(
                              alignment: Alignment.center,
                              width: 90,
                              height: 90,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  addCategoryController.categoryImage.value.url.isNotEmpty
                                      ? CustomImage(
                                          imagePath: addCategoryController.categoryImage.value.url,
                                          fit: BoxFit.cover,
                                          imageType: ImageType.network,
                                          borderRadius: BorderRadius.circular(8),
                                          width: 90,
                                          height: 90,
                                        )
                                      : const Icon(Iconsax.gallery, size: 80),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: InkWell(
                                      onTap: () async {
                                        await addCategoryController.selectCategoryImage();
                                      },
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: AppColors.primary.withValues(alpha: 0.5),
                                        child: const Icon(Iconsax.edit, size: 20, color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSizes.spaceBtwInputFields),
                            Row(
                              children: [
                                Checkbox(
                                  value: addCategoryController.isFeatured.value,
                                  onChanged: (value) {
                                    addCategoryController.changeIsFeatured(value!);
                                  },
                                ),
                                // const SizedBox(width: AppSizes.sm),
                                Text("Featured", style: Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                            const SizedBox(height: AppSizes.spaceBtwInputFields),
                            AppPrimaryButton(
                              label: addCategoryController.isUpdate.value ? "Update Category" : "Create Category",
                              onTap: () async {
                                if (addCategoryController.isUpdate.value) {
                                  await addCategoryController.editCategory();
                                  return;
                                } else {
                                  await addCategoryController.createCategory();
                                  return;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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
