import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/data/controllers/authentication/auth_controller.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/constants/texts.dart';
import '../../../../routes/app_routs.dart';
import 'controllers/app_navigation_controller.dart';
import 'widgets/sidebar_header.dart';
import 'widgets/sidebar_item.dart';
import 'widgets/sidebar_subtitle.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppNavigationController());
    final authController = Get.put(AuthController());

    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(color: AppColors.grey, width: 1),
          ),
        ),
        child: Column(children: [
          //sidebar header --> contians app logo only
          const SideBarHeader(),

          //scrollable part of the sidebar item
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.sm),
              child: Column(
                children: [
                  //sub title widget for menu items
                  const SideBarSubTitle(subtitle: AppTexts.menu),

                  //----------sidebar menu items----------//
                  //
                  //dashboard sidebar item
                  const SideBarItem(route: AppRouts.dashboard, icon: Iconsax.home, title: AppTexts.dashboard),
                  //media sidebar item
                  const SideBarItem(route: AppRouts.media, icon: Iconsax.image, title: AppTexts.media),
                  //bannars sidebar item
                  const SideBarItem(route: AppRouts.bannars, icon: Iconsax.gallery, title: AppTexts.banners),
                  //products sidebar item
                  const SideBarItem(route: AppRouts.products, icon: Iconsax.box, title: AppTexts.products),
                  //categories sidebar item
                  const SideBarItem(route: AppRouts.categories, icon: Iconsax.grid_1, title: AppTexts.categories),
                  //brands sidebar item
                  const SideBarItem(route: AppRouts.brands, icon: Iconsax.medal, title: AppTexts.brands),
                  //customers sidebar item
                  const SideBarItem(route: AppRouts.customers, icon: Iconsax.profile_2user, title: AppTexts.customers),
                  //orders sidebar item
                  const SideBarItem(route: AppRouts.orders, icon: Iconsax.clipboard_text, title: AppTexts.orders),
                  //coupons sidebar item
                  const SideBarItem(route: AppRouts.coupons, icon: Iconsax.discount_shape, title: AppTexts.coupons),

                  //sub title widget for ohter menu items
                  const SideBarSubTitle(subtitle: AppTexts.others),

                  //profile sidebar item
                  const SideBarItem(route: AppRouts.profile, icon: Iconsax.user, title: AppTexts.profile),

                  //settings sidebar item
                  const SideBarItem(route: AppRouts.settings, icon: Iconsax.setting, title: AppTexts.settings),

                  //logout  side bar item
                  SideBarItem(
                    route: AppRouts.logout,
                    icon: Iconsax.logout,
                    title: AppTexts.logout,
                    onTap: () async {
                      await authController.logOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
