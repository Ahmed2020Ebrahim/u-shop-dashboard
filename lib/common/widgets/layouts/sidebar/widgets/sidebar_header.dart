import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class SideBarHeader extends StatelessWidget {
  const SideBarHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);

    return Container(
      height: 150,
      width: double.infinity,
      alignment: Alignment.center,
      child: Image.asset(
        width: 150,
        height: 150,
        isDark ? AppImages.appLightLogo : AppImages.appDarkLogo,
        fit: BoxFit.fill,
      ),
    );
  }
}
