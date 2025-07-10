import 'package:flutter/material.dart';
import 'package:ushop_web/featuers/dashboard/widgets/order_status_chart.dart';
import 'package:ushop_web/featuers/dashboard/widgets/order_status_table.dart';
import 'package:ushop_web/featuers/dashboard/widgets/weakly_sales_chart.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../widgets/dashboard_rates_card.dart';

class DashboardTablet extends StatelessWidget {
  const DashboardTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
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
              ],
            ),
            SizedBox(height: AppSizes.sm),
            Row(
              children: [
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
              ],
            ),
            SizedBox(height: AppSizes.md),

            //weakly sales chart
            WeaklySalesChart(),

            //vertical space
            SizedBox(height: AppSizes.md),

            //orders states table
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
