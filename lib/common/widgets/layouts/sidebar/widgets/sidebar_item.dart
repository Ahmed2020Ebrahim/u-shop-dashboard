import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String route;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    AppNavigationController controller = Get.find();
    return InkWell(
      onTap: onTap ?? () => controller.appNavigate(route),
      onHover: (value) => value ? controller.changeHoverItem(route) : controller.changeHoverItem(''),
      child: Obx(
        () => Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: AppSizes.sm),
          margin: const EdgeInsets.symmetric(vertical: AppSizes.xs),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.sm),
            color: controller.stateCheck(route) == null ? Colors.transparent : AppColors.primary,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: AppSizes.md, left: AppSizes.md),
                child: Icon(
                  icon,
                  color: controller.stateCheck(route) == null ? AppColors.darkGrey : AppColors.white,
                ),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: controller.stateCheck(route) == null ? AppColors.darkGrey : AppColors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
