import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../data/controllers/order/order_controller.dart';
import '../../../data/models/order/order_model.dart';
import '../../../utils/constants/sizes.dart';

class CustomerContactDetailsCard extends StatelessWidget {
  const CustomerContactDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find();
    OrderModel order = orderController.currentOrder.value;
    return RoundedContainer(
      child: CustomeTiteledCard(
        title: "Customer Contact",
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.lg),
          child: Column(
            children: [
              Row(children: [const Icon(Iconsax.user), const SizedBox(width: AppSizes.md), Text(order.userName)]),
              const SizedBox(height: AppSizes.sm),
              Row(children: [const Icon(Icons.phone), const SizedBox(width: AppSizes.md), Text(order.deliveryAddress.phoneNumber)]),
              const SizedBox(height: AppSizes.sm),
              Row(children: [const Icon(Icons.alternate_email), const SizedBox(width: AppSizes.md), Text(order.userEmail)]),
              const SizedBox(height: AppSizes.sm),
              Row(children: [const Icon(Icons.location_on_outlined), const SizedBox(width: AppSizes.md), Text("${order.deliveryAddress.city}, ${order.deliveryAddress.country}")]),
              const SizedBox(height: AppSizes.sm),
              Row(children: [const Icon(Icons.location_city), const SizedBox(width: AppSizes.md), Text("${order.deliveryAddress.state}, ${order.deliveryAddress.street}")]),
              const SizedBox(height: AppSizes.sm),
              Row(children: [const Icon(Icons.email), const SizedBox(width: AppSizes.md), Text(order.deliveryAddress.postalCode)]),
            ],
          ),
        ),
      ),
    );
  }
}
