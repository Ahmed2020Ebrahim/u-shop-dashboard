import 'package:flutter/material.dart';
import 'package:ushop_web/common/widgets/layouts/auth/auth_layout.dart';
import 'package:ushop_web/featuers/authentication/login/views/login_view/widgets/responsive_login_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthLayout(
      child: ResponsiveLoginView(),
    );
  }
}
