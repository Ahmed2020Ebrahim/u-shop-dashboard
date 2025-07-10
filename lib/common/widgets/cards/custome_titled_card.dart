import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../containers/rounded_container.dart';

class CustomeTiteledCard extends StatelessWidget {
  const CustomeTiteledCard({super.key, required this.title, required this.child, this.padding = const EdgeInsets.fromLTRB(AppSizes.mds, AppSizes.sm, AppSizes.mds, AppSizes.mds)});

  final String title;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: double.infinity,
      padding: padding,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.black, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 2),
          Container(
            child: child,
          )
        ],
      ),
    );
  }
}
