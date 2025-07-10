import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/data/controllers/brands/brands_controller.dart';
import 'package:ushop_web/featuers/brands/controllers/add_brand_controller.dart';
import 'package:ushop_web/featuers/brands/controllers/brands_table_controller.dart';
import 'package:ushop_web/featuers/brands/widgets/brands_search_bar.dart';
import 'package:ushop_web/featuers/brands/widgets/brands_table.dart';

import '../../../common/widgets/buttons/app_primary_button.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../routes/app_routs.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class BrandsResponsiveLayout extends StatelessWidget {
  const BrandsResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BrandsController());
    final BrandsTableController brandTableController = Get.put(BrandsTableController());
    final AppNavigationController appNavigationController = Get.find<AppNavigationController>();
    final AddBrandController addBrandController = Get.put(AddBrandController());

    return Scaffold(
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppPrimaryButton(
                label: 'Add New Brand',
                onTap: () {
                  addBrandController.clearData();
                  appNavigationController.appNavigate(AppRouts.addBrand);
                },
                icon: const Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
              //order search bar
              const BrandsSearchBar(),
            ],
          ),

          //space
          const SizedBox(height: AppSizes.md),
          Obx(
            () {
              if (brandTableController.isLoading.value) {
                return const Expanded(
                  child: RoundedContainer(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (brandTableController.filteredbrands.isNotEmpty) {
                return const BrandsTable();
              } else {
                return const Expanded(
                  child: RoundedContainer(
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: Text(
                      "No results found",
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
