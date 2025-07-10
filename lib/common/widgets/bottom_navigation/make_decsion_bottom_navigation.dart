import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../buttons/app_primary_button.dart';

class MakeDecisionBottomNavigation extends StatelessWidget {
  const MakeDecisionBottomNavigation({
    super.key,
    this.discardLabel,
    this.confirmLabel,
    this.onDiscardTap,
    this.onConfirmTap,
  });

  final String? discardLabel;
  final String? confirmLabel;
  final void Function()? onDiscardTap;
  final void Function()? onConfirmTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      height: AppSizes.appBarHeight,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.grey,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (discardLabel != null) OutlinedButton(onPressed: onDiscardTap, child: Text(discardLabel!)),
          const SizedBox(width: AppSizes.sm),
          if (confirmLabel != null)
            SizedBox(
              height: 40,
              child: AppPrimaryButton(
                label: confirmLabel!,
                onTap: onConfirmTap,
              ),
            ),
        ],
      ),
    );
  }
}
