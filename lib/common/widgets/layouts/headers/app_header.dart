import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/images/custom_image.dart';
import 'package:ushop_web/data/controllers/user/user_controller.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/constants/texts.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.grey)),
      ),
      child: AppBar(
        automaticallyImplyLeading: HelperFunctions.isDesktopScreen(context) ? false : true,
        // todo: title widgets << search textfield >>
        title: HelperFunctions.isDesktopScreen(context)
            ? SizedBox(
                width: 300,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: AppTexts.search,
                    prefixIcon: const Icon(Iconsax.search_normal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColors.grey),
                    ),
                  ),
                ),
              )
            : null,

        // todo: leading widget
        leading: !HelperFunctions.isDesktopScreen(context)
            ? IconButton(
                icon: const Icon(Iconsax.menu),
                onPressed: () {
                  scaffoldKey!.currentState!.openDrawer();
                },
              )
            : null,

        // todo: action widgets
        actions: [
          //* search iconButton show in tablet and mobile layout
          if (!HelperFunctions.isDesktopScreen(context))
            IconButton(
              icon: const Icon(Iconsax.search_normal),
              onPressed: () {},
            ),

          //* notification icon button
          IconButton(
            icon: const Icon(Iconsax.notification),
            onPressed: () {},
          ),

          //* user information << image , user name , user email >>
          Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //* user image cicleavatar
                CustomImage(imagePath: userController.currentUser.value.profileImage, width: 40, height: 40, isCircular: true),

                //* space between image and user data
                const SizedBox(width: AppSizes.sm),

                //* user data show in desktop and tablet layout
                if (!HelperFunctions.isMobileScreen(context))
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(child: Text(userController.currentUser.value.userName, style: Theme.of(context).textTheme.titleLarge)),
                      FittedBox(child: Text(userController.currentUser.value.email, style: Theme.of(context).textTheme.labelLarge)),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  //  implement preferredSize
  Size get preferredSize => const Size.fromHeight(AppSizes.appBarHeight + 15);
}
