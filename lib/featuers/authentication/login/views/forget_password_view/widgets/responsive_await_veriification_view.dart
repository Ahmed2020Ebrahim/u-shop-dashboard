import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/app_routs.dart';
import '../../../../../../utils/constants/app_images.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/constants/texts.dart';
import '../../../controller/forget_password_controller.dart';

class ResponsivAwaitVerificationView extends StatelessWidget {
  const ResponsivAwaitVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.close),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwInputFields),
        Container(
          width: 200,
          height: 200,
          padding: const EdgeInsets.symmetric(vertical: AppSizes.md),
          child: Image.asset(
            AppImages.emailSentToVerify,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwInputFields),
        Text(AppTexts.passwordResetEmailSent, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSizes.spaceBtwInputFields),
        Text(AppTexts.dummyEmail, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: AppSizes.spaceBtwInputFields),
        Text(
          AppTexts.forgetPasswordSubtitle,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRouts.login);
              },
              child: const Text(AppTexts.done)),
        ),
        const SizedBox(height: AppSizes.spaceBtwInputFields),
        TextButton(
          onPressed: () {
            ForgetPasswordController.instance.reSendPasswordResetEmail();
          },
          child: const Text(AppTexts.resendEmail),
        ),
      ],
    );
  }
}
