import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/routes/app_routs.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/sizes.dart';

class Breadcrumb extends StatelessWidget {
  const Breadcrumb({
    required this.currentRout,
    required this.currentPage,
    required this.routeSegments,
    super.key,
  });
  final String currentRout;
  final String currentPage;
  final List<String> routeSegments;
  @override
  Widget build(BuildContext context) {
    final AppNavigationController controller = Get.find();
    return Container(
      margin: const EdgeInsets.only(left: AppSizes.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (currentRout != HelperFunctions.capitalizeFirst(AppRouts.dashboard.replaceFirst("/", "")) && currentRout != AppRouts.responsiveScreen)
            Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  children: [
                    Text("Dashboard", style: Theme.of(context).textTheme.labelSmall),
                    ...List.generate(
                      routeSegments.length,
                      (index) => InkWell(
                        onTap: () {},
                        child: Text("/${routeSegments[index]}", style: Theme.of(context).textTheme.labelSmall),
                      ),
                    ),
                  ],
                )),
          Row(
            children: [
              if (routeSegments.length > 1)
                InkWell(
                    onTap: () {
                      controller.appNavigate(controller.getPreviousNavigation(routeSegments));
                    },
                    child: const Icon(Icons.arrow_back)),
              if (routeSegments.length > 1) const SizedBox(width: AppSizes.sm),
              const SizedBox(width: AppSizes.xs),
              Text(currentPage, style: Theme.of(context).textTheme.titleLarge),
            ],
          )
        ],
      ),
    );
  }
}
