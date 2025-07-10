import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/utils/constants/texts.dart';
import 'package:ushop_web/utils/validators/app_validators.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../controller/forget_password_controller.dart';

class ResponsivForgetPasswordView extends StatelessWidget {
  const ResponsivForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    //forget password controller
    final ForgetPasswordController forgetPasswordController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Iconsax.arrow_left),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwInputFields),
        Text(AppTexts.forgetPasswordTitlte, style: Theme.of(context).textTheme.titleLarge),
        Text(AppTexts.forgetPasswordSubtitle, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: AppSizes.spaceBtwSections),
        Form(
          key: forgetPasswordController.forgetPasswordFormKey,
          child: TextFormField(
            controller: forgetPasswordController.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => AppValidators.validateEmail(value),
            decoration: const InputDecoration(
              hintText: AppTexts.email,
              prefixIcon: Icon(Icons.email),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await forgetPasswordController.sendPasswordResetEmail();
            },
            child: const Text(AppTexts.send),
          ),
        )
      ],
    );
  }
}
