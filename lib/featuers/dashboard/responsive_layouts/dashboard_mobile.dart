import 'package:flutter/material.dart';
import 'package:ushop_web/featuers/dashboard/widgets/order_status_chart.dart';
import 'package:ushop_web/featuers/dashboard/widgets/order_status_table.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../widgets/dashboard_rates_card.dart';
import '../widgets/weakly_sales_chart.dart';

class DashboardMobile extends StatelessWidget {
  const DashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DashboardRatesCard(
              title: "Total Sales",
              subtitle: "\$355.0",
              percentage: "25%",
              comparedTo: "Compared to 25 December",
              percentageColor: AppColors.success,
            ),
            SizedBox(height: AppSizes.sm),
            DashboardRatesCard(
              title: "Total Orders",
              subtitle: "\$150.0",
              percentage: "2%",
              comparedTo: "Compared to 30 December",
              percentageColor: AppColors.error,
              rateIcon: Icons.arrow_downward,
            ),
            SizedBox(height: AppSizes.sm),
            DashboardRatesCard(
              title: "Total Users",
              subtitle: "\$150.0",
              percentage: "60%",
              comparedTo: "Compared to 40 December",
              percentageColor: AppColors.success,
            ),
            SizedBox(height: AppSizes.sm),
            DashboardRatesCard(
              title: "Total Revenue",
              subtitle: "\$200.0",
              percentage: "40%",
              comparedTo: "Compared to 50 December",
              percentageColor: AppColors.success,
            ),
            SizedBox(height: AppSizes.md),

            //weakly sales chart
            WeaklySalesChart(),

            //vertical space
            SizedBox(height: AppSizes.md),

            //orders status table
            OrdersStatusTable(),

            //vertical space
            SizedBox(height: AppSizes.md),

            //pi chart order status chart
            OrdersStatusChart(),

            //vertical space
            SizedBox(height: AppSizes.md),
          ],
        ),
      ),
    );
  }
}
