import 'package:flutter/material.dart';

import 'login_form.dart';
import 'login_header.dart';

class ResponsiveLoginView extends StatelessWidget {
  const ResponsiveLoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //login header << image , wellcome , message>>
        LoginHeader(),

        // user can login using email and password from here
        LoginForm(),
      ],
    );
  }
}
