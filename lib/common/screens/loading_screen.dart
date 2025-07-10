import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/utils/constants/app_images.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.appBarHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Center(
              child: Lottie.asset(
                AppImages.apploading1,
                width: 300,
                height: 300,
                repeat: true,
                reverse: false,
                animate: true,
              ),
            ),
            const Text("loading", style: TextStyle(letterSpacing: 2)),
          ],
        ),
      ),
    );
  }
}
