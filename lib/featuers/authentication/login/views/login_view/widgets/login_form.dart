import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/data/controllers/authentication/auth_controller.dart';
import 'package:ushop_web/routes/app_routs.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/constants/texts.dart';
import 'package:ushop_web/utils/validators/app_validators.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Obx(
      () => Form(
        key: controller.signUpFormKey,
        child: Column(
          children: [
            const SizedBox(height: AppSizes.spaceBtwSections),
            TextFormField(
              validator: AppValidators.validateEmail,
              controller: controller.email.value,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct),
                hintText: AppTexts.email,
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),
            TextFormField(
              validator: AppValidators.validatePassword,
              controller: controller.password.value,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      controller.hidePassword.value = !controller.hidePassword.value;
                    },
                    icon: controller.hidePassword.value ? const Icon(Iconsax.eye_slash) : const Icon(Iconsax.eye)),
                prefixIcon: const Icon(Iconsax.password_check),
                hintText: AppTexts.password,
              ),
            ),
            const SizedBox(height: AppSizes.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) {
                          controller.rememberMe.value = !controller.rememberMe.value;
                        },
                        semanticLabel: AppTexts.rememberMe,
                      ),
                      Text(AppTexts.rememberMe, style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(AppRouts.forgetPassword);
                  },
                  child: const Text(AppTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await controller.logIn();
                },
                child: const Text(AppTexts.login),
              ),
            )
          ],
        ),
      ),
    );
  }
}
