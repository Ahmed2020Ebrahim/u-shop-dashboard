import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../containers/rounded_container.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.label,
    this.onTap,
    this.icon,
    this.width,
    this.color = AppColors.buttonPrimary,
    this.labelColor = AppColors.white,
    super.key,
  });
  final void Function()? onTap;
  final String label;
  final Icon? icon;
  final double? width;
  final Color? color;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RoundedContainer(
        width: width,
        borderRadius: 10,
        color: color,
        padding: const EdgeInsets.all(AppSizes.sm),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            icon == null ? const SizedBox() : const SizedBox(width: AppSizes.sm),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: labelColor),
            ),
          ],
        ),
      ),
    );
  }
}
