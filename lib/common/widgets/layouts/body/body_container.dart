import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';

class BodyContainer extends StatelessWidget {
  const BodyContainer({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      margin: const EdgeInsets.fromLTRB(AppSizes.md, 0, AppSizes.md, AppSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(AppSizes.md)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: child ?? const SizedBox(),
    );
  }
}
