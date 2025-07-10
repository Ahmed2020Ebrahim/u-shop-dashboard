import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../common/widgets/images/custom_image.dart';
import '../../../data/controllers/order/order_controller.dart';
import '../../../data/controllers/user/user_controller.dart';
import '../../../data/models/order/order_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';

class OrderCustomerDetailsCard extends StatelessWidget {
  const OrderCustomerDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find();
    OrderModel order = orderController.currentOrder.value;
    UserController userController = Get.put(UserController());
    return RoundedContainer(
      width: double.infinity,
      child: CustomeTiteledCard(
        title: "Customer",
        child: Padding(
          padding: const EdgeInsets.only(top: AppSizes.lg, bottom: AppSizes.md),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: AppSizes.sm),
            leading: userController.getUserImage(order.userId) == null
                ? const CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 30,
                    child: Icon(Iconsax.user, color: AppColors.white, size: 30),
                  )
                : CustomImage(
                    imagePath: userController.getUserImage(order.userId),
                    width: 50,
                    height: 60,
                    imageType: ImageType.network,
                    borderRadius: BorderRadius.circular(12),
                    fit: BoxFit.fill,
                  ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  order.userName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  order.userEmail,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
