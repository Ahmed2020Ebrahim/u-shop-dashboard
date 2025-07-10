import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/controllers/order/order_controller.dart';
import 'package:ushop_web/featuers/bannars/screens/add_banner_responsive_layout.dart';
import 'package:ushop_web/featuers/categories/screens/add_category_responsive_layout.dart';
import 'package:ushop_web/featuers/customers/screens/customer_details_layouts/customer_details_desktop.dart';
import 'package:ushop_web/featuers/customers/screens/customer_details_layouts/customer_details_mobile.dart';
import 'package:ushop_web/featuers/customers/screens/customer_details_layouts/customer_details_tablet.dart';
import 'package:ushop_web/featuers/dashboard/responsive_layouts/dashboard_desktop.dart';
import 'package:ushop_web/featuers/dashboard/responsive_layouts/dashboard_mobile.dart';
import 'package:ushop_web/featuers/dashboard/responsive_layouts/dashboard_tablet.dart';
import 'package:ushop_web/featuers/orders/order_details_layouts/order_details_desktop_layout.dart';
import 'package:ushop_web/featuers/orders/order_details_layouts/order_details_mobile_layout.dart';
import 'package:ushop_web/featuers/orders/order_details_layouts/order_details_tablet_layout.dart';
import 'package:ushop_web/featuers/products/screens/add_products_responsives_layouts/add_product_desktop_layout.dart';
import 'package:ushop_web/featuers/products/screens/add_products_responsives_layouts/add_product_mobile_layout.dart';
import 'package:ushop_web/featuers/products/screens/add_products_responsives_layouts/add_product_tablet_layout.dart';
import 'package:ushop_web/featuers/profile/responsive_layouts/profile_mobile_layout.dart';
import 'package:ushop_web/featuers/profile/responsive_layouts/profile_tablet_layout.dart';

import '../../../common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import '../../../common/widgets/layouts/templates/site_template.dart';
import '../../../routes/app_routs.dart';
import '../../bannars/screens/banners_responseve_layout.dart';
import '../../brands/screens/add_brand_responsive_layout.dart';
import '../../brands/screens/brands_responsive_layout.dart';
import '../../categories/screens/categories_responsive_layout.dart';
import '../../coupons/screens/coupons_screen.dart';
import '../../customers/screens/customer_responsive_layout.dart';
import '../../media/screens/media_screen.dart';
import '../../orders/responsive_layout/orders_responsive_layout.dart';
import '../../profile/responsive_layouts/profile_desktop_layout.dart';
import '../../settings/screens/settings_desktop_layout.dart';
import '../../products/screens/products_responsive_layout.dart';
import '../../settings/screens/settings_mobile_layout.dart';
import '../../settings/screens/settings_tablet_layout.dart';

class DashboardContentView extends StatelessWidget {
  const DashboardContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppNavigationController());
    return Obx(
      () {
        switch (controller.currentRout.value) {
          //dashboard navigations
          case AppRouts.dashboard:
            Get.put(OrderController());
            return const SiteTemplate(desktopLayoutBody: DashboardDesktop(), tabletLayoutBody: DashboardTablet(), mobileLayoutBody: DashboardMobile());
          //
          //media navigations
          case AppRouts.media:
            return const SiteTemplate(desktopLayoutBody: MediaScreen(isSelectable: false));
          //
          //bannars navigations
          case AppRouts.bannars:
            return const SiteTemplate(desktopLayoutBody: BannarsResponsiveLayout());
          case AppRouts.addBanner:
            return const SiteTemplate(desktopLayoutBody: AddBannerResponsiveLayout());
          case AppRouts.editBanner:
            return const SiteTemplate(desktopLayoutBody: AddBannerResponsiveLayout());
          //
          //products navigations
          case AppRouts.products:
            return const SiteTemplate(desktopLayoutBody: ProductsResponsiveLayout());
          case AppRouts.addProduct:
            return const SiteTemplate(desktopLayoutBody: AddProductDesktopLayout(), tabletLayoutBody: AddProductTabletLayout(), mobileLayoutBody: AddProductMobileLayout(), removePadding: true);
          case AppRouts.updateProduct:
            return const SiteTemplate(desktopLayoutBody: AddProductDesktopLayout(), tabletLayoutBody: AddProductTabletLayout(), mobileLayoutBody: AddProductMobileLayout(), removePadding: true);
          //
          //categories navigations
          case AppRouts.categories:
            return const SiteTemplate(desktopLayoutBody: CategoriesResponsiveLayout());
          case AppRouts.addCategory:
            return const SiteTemplate(desktopLayoutBody: AddCategoryResponsiveLayout());
          case AppRouts.updateCategory:
            return const SiteTemplate(desktopLayoutBody: AddCategoryResponsiveLayout());
          //
          //brand navigations
          case AppRouts.brands:
            return const SiteTemplate(desktopLayoutBody: BrandsResponsiveLayout());
          case AppRouts.addBrand:
            return const SiteTemplate(desktopLayoutBody: AddBrandResponsiveLayout());
          case AppRouts.editBrand:
            return const SiteTemplate(desktopLayoutBody: AddBrandResponsiveLayout());
          //
          //customers navigations
          case AppRouts.customers:
            return const SiteTemplate(desktopLayoutBody: CustomerResponsiveLayout());
          case AppRouts.customerDetails:
            return const SiteTemplate(desktopLayoutBody: CustomerDetailsDesktop(), tabletLayoutBody: CustomerDetailsTablet(), mobileLayoutBody: CustomerDetailsMobile());
          //
          //orders navigations
          case AppRouts.orders:
            return const SiteTemplate(desktopLayoutBody: OrdersResponsiveLayout());
          case AppRouts.dashboard + AppRouts.orderDetails:
            return const SiteTemplate(desktopLayoutBody: OrderDetailsDesktopLayout(), tabletLayoutBody: OrderDetailsTabletLayout(), mobileLayoutBody: OrderDetailsMobileLayout());
          case AppRouts.orders + AppRouts.orderDetails:
            return const SiteTemplate(desktopLayoutBody: OrderDetailsDesktopLayout(), tabletLayoutBody: OrderDetailsTabletLayout(), mobileLayoutBody: OrderDetailsMobileLayout());
          case AppRouts.customerDetails + AppRouts.orderDetails:
            return const SiteTemplate(desktopLayoutBody: OrderDetailsDesktopLayout(), tabletLayoutBody: OrderDetailsTabletLayout(), mobileLayoutBody: OrderDetailsMobileLayout());
          //
          //coupons navigations
          case AppRouts.coupons:
            return const SiteTemplate(desktopLayoutBody: CouponsScreen());
          //
          //profile navigations
          case AppRouts.profile:
            return const SiteTemplate(desktopLayoutBody: ProfileDesktopLayout(), tabletLayoutBody: ProfileTabletLayout(), mobileLayoutBody: ProfileMobileLayout());
          //
          //settings navigations
          case AppRouts.settings:
            return const SiteTemplate(desktopLayoutBody: SettingsDesktopLayout(), tabletLayoutBody: SettingsTabletLayout(), mobileLayoutBody: SettingsMobileLayout());
          //
          //default case
          default:
            return const SiteTemplate(desktopLayoutBody: DashboardDesktop(), tabletLayoutBody: DashboardTablet(), mobileLayoutBody: DashboardMobile());
        }
      },
    );
    // return const SiteTemplate(desktopLayoutBody: DesktopLayoutBody(), tabletLayoutBody: TabletLayoutBody(), mobileLayoutBody: MobileLayoutBody());
  }
}
