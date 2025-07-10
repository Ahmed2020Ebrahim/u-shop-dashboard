import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'dashboard_rates_card.dart';

class DashboardTopCards extends StatelessWidget {
  const DashboardTopCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: DashboardRatesCard(
            title: "Total Sales",
            subtitle: "\$355.0",
            percentage: "25%",
            comparedTo: "Compared to 25 December",
            percentageColor: AppColors.success,
          ),
        ),
        SizedBox(width: AppSizes.sm),
        Expanded(
          child: DashboardRatesCard(
            title: "Total Orders",
            subtitle: "\$150.0",
            percentage: "2%",
            comparedTo: "Compared to 30 December",
            percentageColor: AppColors.error,
            rateIcon: Icons.arrow_downward,
          ),
        ),
        SizedBox(width: AppSizes.sm),
        Expanded(
          child: DashboardRatesCard(
            title: "Total Users",
            subtitle: "\$150.0",
            percentage: "60%",
            comparedTo: "Compared to 40 December",
            percentageColor: AppColors.success,
          ),
        ),
        SizedBox(width: AppSizes.sm),
        Expanded(
          child: DashboardRatesCard(
            title: "Total Revenue",
            subtitle: "\$200.0",
            percentage: "40%",
            comparedTo: "Compared to 50 December",
            percentageColor: AppColors.success,
          ),
        ),
        SizedBox(width: AppSizes.sm),
      ],
    );
  }
}
