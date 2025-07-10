import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/cards/custome_titled_card.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/constants/enums.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AddProductController addProductController = Get.find();

    return CustomeTiteledCard(
        title: "Stock & Pricing",
        child: Obx(
          () => Column(
            children: [
              //product type selection
              Padding(
                padding: const EdgeInsets.all(AppSizes.sm),
                child: Row(
                  children: [
                    Text("Product Type", style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(width: AppSizes.md),
                    Radio(
                      value: ProductType.single,
                      groupValue: addProductController.productType.value,
                      onChanged: addProductController.onProductTypeChanged,
                      activeColor: AppColors.primary,
                    ),
                    Text("Single", style: Theme.of(context).textTheme.labelSmall),
                    const SizedBox(width: AppSizes.sm),
                    Radio(
                      value: ProductType.variable,
                      groupValue: addProductController.productType.value,
                      onChanged: addProductController.onProductTypeChanged,
                      activeColor: AppColors.primary,
                    ),
                    Text("Variable", style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),
              //product stock inputs
              TextFormField(
                controller: AddProductController.instance.productStockController,
                validator: addProductController.stockValidator,
                decoration: const InputDecoration(
                  labelText: "Stock",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              //space
              const SizedBox(height: AppSizes.spaceBtwInputFields),
              //product price inputs
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: AddProductController.instance.productPriceController,
                      validator: addProductController.pricesValidator,
                      decoration: const InputDecoration(
                        labelText: "Price",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  //space
                  const SizedBox(width: AppSizes.md),
                  //product discounted price inputs
                  Expanded(
                    child: TextFormField(
                      controller: AddProductController.instance.productDiscountController,
                      validator: addProductController.pricesValidator,
                      decoration: const InputDecoration(
                        labelText: "Discounted Price",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
