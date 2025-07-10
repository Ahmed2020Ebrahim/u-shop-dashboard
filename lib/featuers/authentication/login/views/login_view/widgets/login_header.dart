import 'package:flutter/material.dart';
import 'package:ushop_web/utils/constants/app_images.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/constants/texts.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(width: AppSizes.logoXXXl, height: AppSizes.logoXXXl, padding: const EdgeInsets.symmetric(vertical: AppSizes.md), child: Image.asset(AppImages.appDarkLogo, fit: BoxFit.cover)),
        Text(AppTexts.welcomeBack, style: Theme.of(context).textTheme.titleLarge),
        Text(AppTexts.welcomeSubtitle, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
