import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/bottom_navigation/make_decsion_bottom_navigation.dart';
import '../../../common/widgets/dialogs/dialoges.dart';
import '../../../utils/popups/app_popups.dart';
import '../controllers/add_product_controller.dart';

class AddProductBottomSheet extends StatelessWidget {
  const AddProductBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final AddProductController addProductController = Get.put(AddProductController());

    return Obx(
      () => MakeDecisionBottomNavigation(
        confirmLabel: addProductController.isUpdating.value ? "Update Product" : "Save Product",
        discardLabel: "Discard",
        onConfirmTap: () async {
          if (addProductController.isUpdating.value) {
            await addProductController.validateAndUpdateProduct();
            return;
          } else {
            await addProductController.validateAndUploadProduct();
            return;
          }
        },
        onDiscardTap: () {
          Dialoges.showDefaultDialog(context: context, title: "Discard?", contant: const Text('Do You Want To Discard Changes?'), actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addProductController.clearAllData();
                Get.back();
                AppPopups.showSuccessToast(msg: "Discarded Successfully");
              },
              child: const Text('Discard'),
            ),
          ]);
        },
      ),
    );
  }
}
