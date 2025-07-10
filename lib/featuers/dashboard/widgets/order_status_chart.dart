import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../../../data/controllers/order/order_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'chart_legend_row.dart';

class OrdersStatusChart extends StatelessWidget {
  const OrdersStatusChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.sm),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Orders Status", style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),

          //vertical space
          const SizedBox(height: AppSizes.md),

          //pie chart
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Obx(
              () => PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {}),
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 40,
                  sectionsSpace: 0,
                  sections: orderController.ordersClassification.entries.map(
                    (element) {
                      return PieChartSectionData(
                        color: HelperFunctions.getOrderColor(element.key),
                        title: element.value["Orders"].toString(),
                        value: element.value['Orders']!.toDouble(),
                        radius: 60,
                        titleStyle: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.white),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),

          //vertical space
          const SizedBox(height: AppSizes.lg),

          //chart legend header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.sm),
            child: ChartLegendRow(
              leftWidget: Text("Status"),
              middleWidget: Text("Orders"),
              rightWidget: Text("Total"),
            ),
          ),

          //chart legend items
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...orderController.ordersClassification.entries.map(
                  (e) => ChartLegendRow(
                    leftWidget: Row(
                      children: [
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: HelperFunctions.getOrderColor(e.key),
                        ),
                        const SizedBox(width: AppSizes.sm),
                        Text(e.key.name),
                      ],
                    ),
                    middleWidget: Text(e.value["Orders"].toString()),
                    rightWidget: Text(e.value["Total"]!.toStringAsFixed(2)),
                  ),
                ),
              ],
            ),
          ),
          //vertical space
          const SizedBox(height: AppSizes.lg),
        ],
      ),
    );
  }
}
