import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/controllers/order/order_controller.dart';
import 'package:ushop_web/featuers/dashboard/widgets/weakly_sales_chart.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import '../widgets/dashboard_top_cards.dart';
import '../widgets/order_status_chart.dart';
import '../widgets/order_status_table.dart';

class DashboardDesktop extends StatelessWidget {
  const DashboardDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //dashboard to cards
            DashboardTopCards(),

            //space between rows
            SizedBox(height: AppSizes.md),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //seakly sales chart & orders status table
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // weakly sales chart
                      WeaklySalesChart(),

                      //verical space
                      SizedBox(height: AppSizes.md),

                      //order status table
                      OrdersStatusTable(),

                      //vertical space
                      SizedBox(height: AppSizes.md),
                    ],
                  ),
                ),

                //horizontal space
                SizedBox(width: AppSizes.md),

                //order status chart
                Expanded(
                  flex: 1,
                  child: OrdersStatusChart(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
