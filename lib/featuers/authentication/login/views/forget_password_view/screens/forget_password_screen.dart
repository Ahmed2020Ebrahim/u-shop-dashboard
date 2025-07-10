import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:ushop_web/common/widgets/layouts/auth/auth_layout.dart';
import 'package:ushop_web/featuers/authentication/login/controller/forget_password_controller.dart';

import '../widgets/responsive_forget_password_view.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordController());
    return const AuthLayout(
      child: ResponsivForgetPasswordView(),
    );
  }
}
