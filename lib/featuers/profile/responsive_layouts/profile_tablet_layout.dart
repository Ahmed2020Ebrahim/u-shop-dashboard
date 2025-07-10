import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/data/controllers/user/user_controller.dart';
import 'package:ushop_web/utils/constants/app_images.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_details_form.dart';
import '../widgets/profile_image_card.dart';

class ProfileTabletLayout extends StatelessWidget {
  const ProfileTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final ProfileController profileController = Get.put(ProfileController());

    return Obx(
      () => Scaffold(
        body: profileController.isLoading.value
            ? Center(
                child: Lottie.asset(AppImages.apploading2, width: 100, height: 100),
              )
            : const SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //profile image card
                    ProfileImageCard(),
                    //space
                    SizedBox(height: AppSizes.md),
                    //profile details form
                    ProfileDetailsForm(),
                  ],
                ),
              ),
      ),
    );
  }
}
