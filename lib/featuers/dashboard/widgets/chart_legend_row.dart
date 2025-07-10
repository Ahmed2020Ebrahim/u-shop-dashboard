import 'package:flutter/material.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

class ChartLegendRow extends StatelessWidget {
  const ChartLegendRow({required this.rightWidget, required this.middleWidget, required this.leftWidget, super.key});
  final Widget rightWidget;
  final Widget middleWidget;
  final Widget leftWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(flex: 1, child: Align(alignment: Alignment.centerLeft, child: leftWidget)),
                Flexible(flex: 1, child: Align(alignment: Alignment.center, child: middleWidget)),
                Flexible(flex: 1, child: Align(alignment: Alignment.centerRight, child: rightWidget)),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
