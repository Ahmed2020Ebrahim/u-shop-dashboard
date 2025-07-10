import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/buttons/app_primary_button.dart';
import 'package:ushop_web/common/widgets/cards/custome_titled_card.dart';
import 'package:ushop_web/common/widgets/containers/rounded_container.dart';
import 'package:ushop_web/common/widgets/images/custom_image.dart';
import 'package:ushop_web/featuers/brands/controllers/add_brand_controller.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';
import 'package:ushop_web/utils/validators/app_validators.dart';

import '../../../data/controllers/category/category_controller.dart';

class AddBrandResponsiveLayout extends StatelessWidget {
  const AddBrandResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    //category controller
    final CategoryController categoryController = Get.put(CategoryController());
    final AddBrandController addBrandController = Get.put(AddBrandController());

    return Obx(
      () => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppSizes.md),
              RoundedContainer(
                width: HelperFunctions.isDesktopScreen(context) ? 600 : null,
                child: CustomeTiteledCard(
                  title: addBrandController.isUpdate.value ? "Update Brand" : "Create New Brand",
                  child: Column(
                    children: [
                      const SizedBox(height: AppSizes.md),
                      Form(
                        key: addBrandController.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: addBrandController.newBrandNameController,
                              validator: (value) => AppValidators.validateEmptyTextField("Brand Name", value),
                              decoration: const InputDecoration(
                                labelText: "Brand Name",
                                prefixIcon: Icon(Iconsax.box),
                              ),
                            ),
                            const SizedBox(height: AppSizes.spaceBtwInputFields),
                            Text("Select Category", style: Theme.of(context).textTheme.labelSmall),
                            const SizedBox(height: AppSizes.sm),
                            categoryController.loader.value
                                ? Container(alignment: Alignment.center, height: 150, child: const CircularProgressIndicator())
                                : SizedBox(
                                    height: 150,
                                    child: ListView(
                                      children: [
                                        Wrap(
                                          children: [
                                            ...List.generate(
                                              categoryController.allCategories.length,
                                              (index) => Container(
                                                margin: const EdgeInsets.only(right: AppSizes.sm, bottom: AppSizes.sm),
                                                child: ChoiceChip(
                                                  labelPadding: EdgeInsets.zero,
                                                  backgroundColor: AppColors.white,
                                                  label: Text(categoryController.allCategories[index].name),
                                                  selected: addBrandController.isCategorySelected(categoryController.allCategories[index].id),
                                                  onSelected: (value) {
                                                    addBrandController.onCategorySelected(categoryController.allCategories[index]);
                                                    addBrandController.selectedCategoriesIds.refresh();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
                                  addBrandController.selectedImage.value.url.isEmpty
                                      ? const Icon(Iconsax.gallery, size: 80)
                                      : CustomImage(
                                          imagePath: addBrandController.selectedImage.value.url,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.fill,
                                          borderRadius: BorderRadius.circular(10),
                                          imageType: ImageType.network,
                                        ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: InkWell(
                                      onTap: () async {
                                        //open media screen to select image
                                        await addBrandController.selectBrandImage();
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
                                    value: addBrandController.isFeatured.value,
                                    onChanged: (value) {
                                      addBrandController.onFeaturedChanged(value!);
                                    }),
                                // const SizedBox(width: AppSizes.sm),
                                Text("Featured", style: Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                            const SizedBox(height: AppSizes.spaceBtwInputFields),
                            AppPrimaryButton(
                              label: addBrandController.isUpdate.value ? "Update" : "Create",
                              onTap: () async {
                                if (addBrandController.isUpdate.value) {
                                  await addBrandController.editBrand();
                                } else {
                                  await addBrandController.createBrand();
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
            ],
          ),
        ),
      ),
    );
  }
}
