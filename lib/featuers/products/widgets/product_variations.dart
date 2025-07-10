import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/sizes.dart';
import 'product_variation_expansion_tile.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AddProductController addProductController = Get.find();
    return Obx(
      () => addProductController.productType.value == ProductType.variable
          ? CustomeTiteledCard(
              title: "Product Variations",
              child: addProductController.productVariatiosAttributesList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(AppImages.thinking, width: 150, height: 150, animate: true),
                        const SizedBox(height: AppSizes.md),
                        Text(
                          addProductController.productAttributesList.length == 1 ? "Only One Attribute Is Added , No Need To Create Variations" : "No Variations Added For This Product",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    )
                  : const ProductVariationExpansionTile(),
            )
          : const SizedBox(),
    );
  }
}
