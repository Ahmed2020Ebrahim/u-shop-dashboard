import 'package:flutter/material.dart';
import 'package:ushop_web/common/widgets/layouts/auth/auth_layout.dart';

class VerifyComplatedView extends StatelessWidget {
  const VerifyComplatedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthLayout(
      child: Column(
        children: [
          Center(
            child: Text("done"),
          )
        ],
      ),
    );
  }
}
