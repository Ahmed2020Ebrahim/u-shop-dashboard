import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';

import '../../../common/widgets/buttons/app_primary_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CreatVariationsButton extends StatelessWidget {
  const CreatVariationsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AddProductController addProductController = Get.find();
    return Column(
      children: [
        const SizedBox(height: AppSizes.md),
        Center(
          child: AppPrimaryButton(
            width: 200,
            label: "Create Variations",
            onTap: () {
              addProductController.generateVariations();
            },
            icon: const Icon(
              Iconsax.trend_up,
              color: AppColors.white,
            ),
          ),
        )
      ],
    );
  }
}
