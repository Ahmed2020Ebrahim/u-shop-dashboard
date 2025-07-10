import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/routes/app_routs.dart';
import 'package:ushop_web/utils/logging/app_logger.dart';

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    html.document.title = 'Ushop';
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    AppNavigationController controller = Get.find();
    if (previousRoute != null) {
      AppLogger.warning(previousRoute.settings.name.toString());
      for (var routeName in AppRouts.sideBarItemsRouts) {
        if (previousRoute.settings.name == routeName) {
          controller.activeItem.value = routeName;
        }
      }
    }
  }
}
