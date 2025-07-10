import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ushop_web/common/widgets/buttons/app_primary_button.dart';
import 'package:ushop_web/common/widgets/cards/custome_titled_card.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';

import '../controllers/add_product_controller.dart';

class ProductAttributesCard extends StatelessWidget {
  const ProductAttributesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = HelperFunctions.isDesktopScreen(context);
    return CustomeTiteledCard(
      padding: const EdgeInsets.all(AppSizes.md),
      title: "Add Products Attributes",
      child: Column(
        children: [
          const SizedBox(height: AppSizes.md),
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isDesktop ? 3 : 2,
                  child: TextFormField(
                    controller: AddProductController.instance.attributeNameController,
                    decoration: InputDecoration(
                      labelText: "Attribute Name",
                      border: const OutlineInputBorder(),
                      errorText: AddProductController.instance.attributeNameError!.value.isEmpty ? null : AddProductController.instance.attributeNameError!.value,
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Obx(
                  () => Expanded(
                    flex: isDesktop ? 6 : 2,
                    child: TextFormField(
                      controller: AddProductController.instance.attributesFieldValueController,
                      decoration: InputDecoration(
                        hintText: AddProductController.instance.productType.value == ProductType.single ? null : "Inter values separated by | ex red | green",
                        errorText: AddProductController.instance.attributesFieldValueError!.value.isEmpty ? null : AddProductController.instance.attributesFieldValueError!.value,
                        alignLabelWithHint: true,
                        labelText: "Attributes Values",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  flex: 1,
                  child: AppPrimaryButton(
                    label: "Add",
                    labelColor: AppColors.black,
                    icon: const Icon(
                      Icons.add,
                    ),
                    onTap: () {
                      // Add the attribute to the list
                      AddProductController.instance.addAttribute();
                    },
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
