import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/general_bindinges.dart';
import 'routes/app_routs.dart';
import 'utils/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      getPages: AppRouts.getPages,
      initialRoute: AppRouts.dashboard,
      initialBinding: GeneralBindinges(),
      // navigatorObservers: [
      //   AppNavigatorObserver(),
      // ],
      debugShowCheckedModeBanner: false,
    );
  }
}
