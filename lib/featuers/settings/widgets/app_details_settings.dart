import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/featuers/settings/controllers/settings_controller.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';
import 'package:ushop_web/utils/validators/app_validators.dart';

import '../../../common/widgets/buttons/app_primary_button.dart';
import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../utils/constants/sizes.dart';

class AppDetailsSettings extends StatelessWidget {
  const AppDetailsSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.put(SettingsController());
    return CustomeTiteledCard(
      title: "App Settings",
      child: Form(
        key: settingsController.keyForm,
        child: HelperFunctions.isDesktopScreen(context)
            ? Column(
                children: [
                  const SizedBox(height: AppSizes.md),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: settingsController.appNamerController,
                          validator: (value) => AppValidators.validateEmptyTextField("AppName", value),
                          decoration: const InputDecoration(
                            labelText: "App Name",
                            prefixIcon: Icon(Iconsax.user),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.sm),
                      Expanded(
                        child: TextFormField(
                          controller: settingsController.supportEmailController,
                          validator: (value) => AppValidators.validateEmail(value),
                          decoration: const InputDecoration(
                            labelText: "Support Email",
                            prefixIcon: Icon(Iconsax.user),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: settingsController.taxRateController,
                          validator: (value) => AppValidators.doubleValidation(value),
                          decoration: const InputDecoration(
                            labelText: "Tax Rate (%)",
                            prefixIcon: Icon(Iconsax.percentage_circle),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.sm),
                      Expanded(
                        child: TextFormField(
                          controller: settingsController.shippingCostController,
                          validator: (value) => AppValidators.doubleValidation(value),
                          decoration: const InputDecoration(
                            labelText: "Shipping Cost (\$)",
                            prefixIcon: Icon(Iconsax.ship),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.sm),
                      Expanded(
                        child: TextFormField(
                          controller: settingsController.freeShippingThresholdController,
                          validator: (value) => AppValidators.doubleValidation(value),
                          decoration: const InputDecoration(
                            labelText: "Free Shipping Threshold (\$)",
                            prefixIcon: Icon(Iconsax.ship),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  AppPrimaryButton(
                    label: "Update App Settings",
                    onTap: () async {
                      await settingsController.updateAppSettings();
                    },
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                ],
              )
            : Column(
                children: [
                  //space
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: settingsController.appNamerController,
                    validator: (value) => AppValidators.validateEmptyTextField("AppName", value),
                    decoration: const InputDecoration(
                      labelText: "App Name",
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: settingsController.supportEmailController,
                    validator: (value) => AppValidators.validateEmail(value),
                    decoration: const InputDecoration(
                      labelText: "Support Email",
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: settingsController.taxRateController,
                    validator: (value) => AppValidators.doubleValidation(value),
                    decoration: const InputDecoration(
                      labelText: "Tax Rate (%)",
                      prefixIcon: Icon(Iconsax.percentage_circle),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: settingsController.shippingCostController,
                    validator: (value) => AppValidators.doubleValidation(value),
                    decoration: const InputDecoration(
                      labelText: "Shipping Cost (\$)",
                      prefixIcon: Icon(Iconsax.ship),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: settingsController.freeShippingThresholdController,
                    validator: (value) => AppValidators.doubleValidation(value),
                    decoration: const InputDecoration(
                      labelText: "Free Shipping Threshold (\$)",
                      prefixIcon: Icon(Iconsax.ship),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  AppPrimaryButton(
                    label: "Update App Settings",
                    onTap: () async {
                      await settingsController.updateAppSettings();
                    },
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),
                ],
              ),
      ),
    );
  }
}
