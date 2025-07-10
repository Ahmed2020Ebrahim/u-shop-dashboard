import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/customer_controller.dart';

class CurrentCustomerShippingAddressCard extends StatelessWidget {
  const CurrentCustomerShippingAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerController customerController = Get.find();

    return RoundedContainer(
      child: CustomeTiteledCard(
        title: "Shipping Address",
        child: Column(
          children: [
            Row(
              children: [
                Expanded(flex: 1, child: Text("Name:", style: Theme.of(context).textTheme.titleLarge)),
                Expanded(flex: 3, child: Text(customerController.currentUserSelectedAddress.value.name)),
              ],
            ),
            //space
            const SizedBox(height: AppSizes.sm),
            Row(
              children: [
                Expanded(flex: 1, child: Text("Country:", style: Theme.of(context).textTheme.titleLarge)),
                Expanded(flex: 3, child: Text(customerController.currentUserSelectedAddress.value.country)),
              ],
            ),
            //space
            const SizedBox(height: AppSizes.sm),
            Row(
              children: [
                Expanded(flex: 1, child: Text("Phone Number:", style: Theme.of(context).textTheme.titleLarge)),
                Expanded(flex: 3, child: Text(customerController.currentUserSelectedAddress.value.phoneNumber)),
              ],
            ),
            //space
            const SizedBox(height: AppSizes.sm),
            Row(
              children: [
                Expanded(flex: 1, child: Text("Address:", style: Theme.of(context).textTheme.titleLarge)),
                Expanded(
                  flex: 3,
                  child: Text(
                    "${customerController.currentUserSelectedAddress.value.street}, ${customerController.currentUserSelectedAddress.value.city}, ${customerController.currentUserSelectedAddress.value.state}, ${customerController.currentUserSelectedAddress.value.country}",
                  ),
                ),
              ],
            ),
            //space
            const SizedBox(height: AppSizes.sm),
            Row(
              children: [
                Expanded(flex: 1, child: Text("Postal code:", style: Theme.of(context).textTheme.titleLarge)),
                Expanded(
                  flex: 3,
                  child: Text(customerController.currentUserSelectedAddress.value.postalCode),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
