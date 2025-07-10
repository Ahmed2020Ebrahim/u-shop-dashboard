import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/buttons/app_primary_button.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/data/controllers/brands/brands_controller.dart';
import 'package:ushop_web/featuers/bannars/controllers/bannars_table_controller.dart';
import 'package:ushop_web/featuers/bannars/widgets/banners_table.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../../../routes/app_routs.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class BannarsResponsiveLayout extends StatelessWidget {
  const BannarsResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BrandsController());
    final BannersTableController controller = Get.put(BannersTableController());
    final AppNavigationController appNavigationController = Get.find();

    return Scaffold(
      body: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: AppPrimaryButton(
                label: "Add New Banner",
                onTap: () {
                  //navigate to add banner
                  appNavigationController.appNavigate(HelperFunctions.capitalizeFirst(AppRouts.addBanner));
                },
                width: 200,
                icon: const Icon(Icons.add, color: AppColors.white),
              )),
          //space
          const SizedBox(height: AppSizes.md),
          Obx(
            () {
              if (controller.isLoading.value) {
                return const Expanded(
                  child: RoundedContainer(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (controller.bannersList.isNotEmpty) {
                return const BannersTable();
              } else {
                return const Expanded(
                  child: RoundedContainer(
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: Text(
                      "No items found",
                      style: TextStyle(fontSize: 18, color: AppColors.darkGrey),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
