import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../common/widgets/images/custom_image.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/customer_controller.dart';

class CustomerInformationCard extends StatelessWidget {
  const CustomerInformationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomerController customerController = Get.find();

    return RoundedContainer(
      width: double.infinity,
      child: CustomeTiteledCard(
        title: "Customer Information",
        child: Column(
          children: [
            //space
            const SizedBox(height: AppSizes.md),

            ListTile(
              contentPadding: const EdgeInsets.only(left: AppSizes.sm),
              leading: customerController.currentCustomer.value.profileImage.isEmpty
                  ? CustomImage(
                      imageType: ImageType.asset,
                      imagePath: AppImages.defaultUserImage,
                      width: 50,
                      height: 50,
                      fit: BoxFit.fill,
                      borderRadius: BorderRadius.circular(8),
                    )
                  : CustomImage(
                      imageType: ImageType.network,
                      imagePath: customerController.currentCustomer.value.profileImage,
                      width: 50,
                      height: 50,
                      fit: BoxFit.fill,
                      borderRadius: BorderRadius.circular(8),
                    ),
              title: Text("${customerController.currentCustomer.value.firstName} ${customerController.currentCustomer.value.lastName}"),
              subtitle: Text(customerController.currentCustomer.value.email),
            ),
            //space
            const SizedBox(height: AppSizes.md),
            Row(
              children: [
                Text("User Name:", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(width: AppSizes.md),
                Text(customerController.currentCustomer.value.userName, style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
            Row(
              children: [
                Text("Phone Number:", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(width: AppSizes.md),
                Text(customerController.currentCustomer.value.phoneNumber, style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
            Row(
              children: [
                Text("User Country:", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(width: AppSizes.md),
                Text(customerController.currentUserSelectedAddress.value.country, style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
            //space
            const SizedBox(height: AppSizes.sm),
            const Divider(),
            //space

            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Text("Last Order", style: Theme.of(context).textTheme.titleLarge),
                          subtitle: Text("${customerController.getDaysSinceLastOrder()} days ago #[${customerController.getLastOrderId()?.substring(0, 8)}]"),
                        )),
                    Expanded(
                        flex: 1,
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Text("Average Order Value", style: Theme.of(context).textTheme.titleLarge),
                          subtitle: Text("\$${customerController.getOrdersAverage().toStringAsFixed(2)}"),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Text("Regestered", style: Theme.of(context).textTheme.titleLarge),
                          subtitle: Text("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"),
                        )),
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text("Email Marketing", style: Theme.of(context).textTheme.titleLarge),
                        subtitle: const Text("Subscribed"),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
