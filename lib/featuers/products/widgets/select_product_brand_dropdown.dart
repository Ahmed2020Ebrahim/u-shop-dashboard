import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../data/controllers/brands/brands_controller.dart';
import '../../../data/models/brand/brand_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class SelectProductBrandDropdown extends StatelessWidget {
  const SelectProductBrandDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final BrandsController brandsController = Get.put(BrandsController());
    final AddProductController addProductController = Get.find();
    return CustomeTiteledCard(
      title: "Brand",
      child: Column(
        children: [
          //space
          const SizedBox(height: AppSizes.sm),
          Obx(() {
            return DropDownTextField(
              enableSearch: true,
              controller: addProductController.dropDownController,
              dropDownList: [
                ...brandsController.allBrands.map(
                  (brand) => DropDownValueModel(
                    name: brand.name,
                    value: brand,
                  ),
                ),
              ],
              onChanged: (value) {
                final selectedBrand = value?.value as BrandModel?;
                if (value != null) {
                  addProductController.setCurrentProductBrand(selectedBrand!);
                }
              },
              dropDownIconProperty: IconProperty(
                icon: Iconsax.box,
                color: AppColors.darkerGrey,
                size: 30,
              ),
            );
          }),
        ],
      ),
    );
  }
}
