import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/utils/constants/app_images.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(AppImages.coupoun, width: 200, height: 200, fit: BoxFit.fill),
          //space
          const SizedBox(height: AppSizes.lg),
          const Text("No coupouns added yet"),
        ],
      ),
    );
  }
}
