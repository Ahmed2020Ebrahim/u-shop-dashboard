import 'package:flutter/material.dart';

class ResponsiveLayOut extends StatelessWidget {
  const ResponsiveLayOut({super.key, required this.desktopLayout, required this.tabletLayout, required this.mobileLayout});
  // desktop layout for large screens
  final Widget desktopLayout;

  // tablet layout for medium screens
  final Widget tabletLayout;

  // mobile layout for small screens
  final Widget mobileLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        double width = constraints.maxWidth;

        if (width >= 1366) {
          return desktopLayout; // For desktops and large screens
        } else if (width <= 1366 && width >= 768) {
          return tabletLayout; // For tablets and medium screens
        } else {
          return mobileLayout; // For mobile phones and small screens
        }
      },
    );
  }
}
