import 'package:flutter/material.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../utils/constants/sizes.dart';

class BillingAddressCard extends StatelessWidget {
  const BillingAddressCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: double.infinity,
      child: CustomeTiteledCard(
        title: "Billing Address",
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(". . . . .", style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
