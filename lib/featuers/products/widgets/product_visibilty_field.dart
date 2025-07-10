import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/constants/enums.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';

class ProductVisibiltyField extends StatelessWidget {
  const ProductVisibiltyField({super.key});

  @override
  Widget build(BuildContext context) {
    final AddProductController addProductController = Get.find();

    return CustomeTiteledCard(
      title: "Visibility",
      child: Obx(
        () => Column(
          children: [
            //space
            const SizedBox(height: AppSizes.sm),
            Row(
              children: [
                Radio(
                  value: ProductVisibility.published,
                  groupValue: addProductController.productVisibility.value,
                  onChanged: addProductController.setProductVisibility,
                  activeColor: AppColors.primary,
                ),
                Text("Published", style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: ProductVisibility.hidden,
                  groupValue: addProductController.productVisibility.value,
                  onChanged: addProductController.setProductVisibility,
                  activeColor: AppColors.primary,
                ),
                Text("Hidden", style: Theme.of(context).textTheme.labelSmall),
              ],
            )
          ],
        ),
      ),
    );
  }
}
