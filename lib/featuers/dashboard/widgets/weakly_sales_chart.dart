import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ushop_web/common/widgets/containers/rounded_container.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';

class WeaklySalesChart extends StatelessWidget {
  const WeaklySalesChart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // generate randome int between 10 to 30
    final random = Random();
    List<int> randomList = [];
    for (var i = 0; i < 7; i++) {
      int randomNumber = 10 + random.nextInt(21);
      randomList.add(randomNumber);
    }

    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.sm),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Weakly Sales Overview", style: Theme.of(context).textTheme.headlineSmall),
            ),
          ),
          const SizedBox(height: AppSizes.md),

          // Placeholder for the chart widget
          SizedBox(
            width: double.infinity,
            height: 300,
            //fl_chart
            child: BarChart(
              BarChartData(
                //set max y
                maxY: 30,

                //setting background color
                // backgroundColor: Colors.transparent,

                //setting some place in the grid to set a color to it
                // rangeAnnotations: RangeAnnotations(
                //   verticalRangeAnnotations: [
                //     VerticalRangeAnnotation(
                //       x1: 0.5,
                //       x2: 0.6,
                //       color: Colors.red.withOpacity(0.3),
                //     ),
                //   ],
                //   horizontalRangeAnnotations: [
                //     HorizontalRangeAnnotation(
                //       y1: 8,
                //       y2: 12,
                //       color: Colors.green.withOpacity(0.2),
                //     ),
                //   ],
                // ),

                //setting the alignment
                alignment: BarChartAlignment.spaceAround,

                //this set the space between every BarChartGroupData
                groupsSpace: 50,
                //setting rotaion of the table
                //1 means it will not rotate
                //2 means rotate 90 degree to the right
                //3 means rotate 180 degree to the right
                //4 means rotate 270 degree to the right
                rotationQuarterTurns: 4,
                //setting extraLinesData
                // extraLinesData: ExtraLinesData(
                //   extraLinesOnTop: false,
                //   verticalLines: [VerticalLine(x: 5, color: AppColors.error)],
                //   horizontalLines: [HorizontalLine(y: 0, color: AppColors.error)],
                // ),

                //setting grid data
                gridData: const FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
                ),
                //setting titles for the chart
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      reservedSize: 50,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        final int index = value.toInt() % days.length;
                        return Text(days[index]);
                      },
                    ),
                  ),
                ),

                //setting borders for the chart
                borderData: FlBorderData(
                  show: false,
                  // border: Border.all(color: Colors.transparent),
                ),

                //seting bar touch response
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        'Group ${group.x}\n',
                        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: '${rod.toY}',
                            style: const TextStyle(color: Colors.yellow, fontSize: 14),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                //setting bar groups
                barGroups: [
                  ...List.generate(
                    7,
                    (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: randomList[index].toDouble(),
                            color: AppColors.primary,
                            width: 20,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
