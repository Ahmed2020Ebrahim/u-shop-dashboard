import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/shimmer/custom_shimmer.dart';
import 'package:ushop_web/utils/constants/app_images.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../data/controllers/user/user_controller.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Obx(() {
      if (controller.isLoading.value) {
        return const CircleAvatar(radius: 50, child: CustomShimmer(width: 100, height: 100, isCircular: true));
      } else {
        if (controller.currentUser.value.profileImage == "") {
          return const CircleAvatar(
            backgroundColor: AppColors.white,
            radius: 50,
            backgroundImage: AssetImage(AppImages.defaultUserImage),
          );
        } else {
          return Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: controller.currentUser.value.profileImage,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholder: (context, url) => const CustomShimmer(
                    width: 100,
                    height: 100,
                    isCircular: true,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }
      }
    });
  }
}
