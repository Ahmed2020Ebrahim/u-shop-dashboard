import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/layouts/headers/app_header.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/app_sidebar.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../layouts/headers/breadcrumb.dart';
import '../../layouts/sidebar/controllers/app_navigation_controller.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key, required this.body, this.removePadding = false});
  final Widget? body;
  final bool removePadding;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppNavigationController());
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppSidebar(), //drawer -> side navigation bar
      appBar: AppHeader(scaffoldKey: scaffoldKey),
      body: LayoutBuilder(builder: (context, constraints) {
        final layoutWidth = constraints.maxWidth;
        return SizedBox(
          width: layoutWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              //body container
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 8, bottom: removePadding ? 0 : 20, left: removePadding ? 0 : 16, right: removePadding ? 0 : 16),
                  child: body ?? const SizedBox(child: Text('no added widgets')),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
