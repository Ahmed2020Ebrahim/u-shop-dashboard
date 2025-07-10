import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:ushop_web/data/repositories/authentication/auth_repository.dart';
import 'package:ushop_web/routes/app_routs.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route == AppRouts.login) {
      return AuthRepository.instance.isAuthenticated ? const RouteSettings(name: AppRouts.dashboard) : null;
    }
    return AuthRepository.instance.isAuthenticated ? null : const RouteSettings(name: AppRouts.login);
  }
}
