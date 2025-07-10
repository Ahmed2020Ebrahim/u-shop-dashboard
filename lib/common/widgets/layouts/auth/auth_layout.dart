import 'package:flutter/material.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool isMobile = HelperFunctions.isMobileScreen(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: isMobile ? 360 : 500,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(AppSizes.defaultSpace, AppSizes.xl, AppSizes.defaultSpace, AppSizes.xl * 1.5),
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
