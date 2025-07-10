import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import '../controllers/settings_controller.dart';
import '../widgets/app_details_settings.dart';
import '../widgets/app_image_settings.dart';

class SettingsDesktopLayout extends StatelessWidget {
  const SettingsDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.put(SettingsController());
    return Scaffold(
      body: Obx(
        () => settingsController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : const SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AppImageSettings(),
                        ),
                        SizedBox(width: AppSizes.md),
                        Expanded(
                          flex: 2,
                          child: AppDetailsSettings(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
