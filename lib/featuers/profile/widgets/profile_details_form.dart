import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/widgets/buttons/app_primary_button.dart';
import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/profile_controller.dart';

class ProfileDetailsForm extends StatelessWidget {
  const ProfileDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return CustomeTiteledCard(
      title: "Profile Details",
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.md),
            Row(
              children: [
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: TextFormField(
                    controller: profileController.firstNameController,
                    decoration: const InputDecoration(
                      labelText: "First Name",
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: TextFormField(
                    controller: profileController.lastNameController,
                    decoration: const InputDecoration(
                      labelText: "Last Name",
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),
            Row(
              children: [
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: TextFormField(
                    controller: profileController.emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.alternate_email_outlined),
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: TextFormField(
                    controller: profileController.phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: "phone Number",
                      prefixIcon: Icon(Iconsax.mobile),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.lg),
            AppPrimaryButton(
              label: "Update Profile",
              onTap: () async {
                await profileController.updateProfile();
              },
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),
          ],
        ),
      ),
    );
  }
}
