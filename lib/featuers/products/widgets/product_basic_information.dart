import 'package:flutter/material.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';
import 'package:ushop_web/utils/validators/app_validators.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../utils/constants/sizes.dart';

class ProductBasicInformation extends StatelessWidget {
  const ProductBasicInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: double.infinity,
      child: CustomeTiteledCard(
        title: "Basic Information",
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
              child: TextFormField(
                controller: AddProductController.instance.productTitleController,
                validator: (value) {
                  return AppValidators.validateEmptyTextField("Product Title", value);
                },
                decoration: const InputDecoration(
                  labelText: 'Product Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            //space
            const SizedBox(height: AppSizes.sm),
            //
            TextFormField(
              controller: AddProductController.instance.productDescriptionController,
              validator: (value) {
                return AppValidators.validateEmptyTextField("Product Description", value);
              },
              keyboardType: TextInputType.multiline,
              minLines: 6,
              maxLines: null,
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Product Description',
                border: OutlineInputBorder(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
