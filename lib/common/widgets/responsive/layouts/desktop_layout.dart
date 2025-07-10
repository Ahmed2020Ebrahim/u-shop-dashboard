import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/layouts/headers/app_header.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';
import '../../layouts/headers/breadcrumb.dart';
import '../../layouts/sidebar/app_sidebar.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, required this.body, this.removePadding = false});
  final Widget? body;
  final bool removePadding;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppNavigationController());
    return LayoutBuilder(builder: (context, constraints) {
      final sideWidth = constraints.maxWidth / 5;
      final contentWidth = constraints.maxWidth * 4 / 5;
      return Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //drawer -> side navigation bar
            SizedBox(width: sideWidth, child: const AppSidebar()),
            //main content

            SizedBox(
              width: contentWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //app bar -> top navigation bar
                  const AppHeader(),
                  //navigation data
                  Obx(
                    () => Breadcrumb(
                      currentRout: HelperFunctions.capitalizeFirst(
                        controller.currentRout.value.replaceFirst("/", ""),
                      ),
                      currentPage: HelperFunctions.capitalizeFirst(controller.getLastRouteSegment(controller.currentRout.value)),
                      routeSegments: controller.routeSegments,
                    ),
                  ),
                  //main content

                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8, left: removePadding ? 0 : 16, bottom: removePadding ? 0 : 20, right: removePadding ? 0 : 16),
                      child: body ?? const SizedBox(child: Text('no added widgets')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
