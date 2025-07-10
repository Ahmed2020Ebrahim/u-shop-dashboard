import 'package:flutter/material.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../utils/constants/sizes.dart';

class DashboardRatesCard extends StatelessWidget {
  const DashboardRatesCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.percentage,
    required this.comparedTo,
    this.percentageColor,
    this.rateIcon = Icons.arrow_upward,
  });

  final String title;
  final String subtitle;
  final String percentage;
  final String comparedTo;
  final Color? percentageColor;
  final IconData? rateIcon;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      color: Colors.white,
      padding: const EdgeInsets.all(20.0),
      borderRadius: 20.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.darkGrey, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(subtitle, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.black, fontWeight: FontWeight.bold)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(rateIcon, size: 14, color: percentageColor ?? AppColors.black),
                      const SizedBox(width: 2),
                      Text(
                        percentage,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: percentageColor ?? AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  Text(comparedTo, style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.darkGrey)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
