import 'package:flutter/material.dart';
import 'package:ushop_web/common/widgets/layouts/auth/auth_layout.dart';
import '../../forget_password_view/widgets/responsive_await_veriification_view.dart';

class AwaitVerificationScreen extends StatelessWidget {
  const AwaitVerificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const AuthLayout(
      child: ResponsivAwaitVerificationView(),
    );
  }
}
