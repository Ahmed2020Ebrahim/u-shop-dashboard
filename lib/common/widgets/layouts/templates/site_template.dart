import 'package:flutter/material.dart';
import '../../responsive/layouts/desktop_layout.dart';
import '../../responsive/layouts/mobile_layout.dart';
import '../../responsive/layouts/tablet_layout.dart';
import '../../responsive/responsive_layout.dart';

class SiteTemplate extends StatelessWidget {
  const SiteTemplate({
    super.key,
    this.desktopLayoutBody,
    this.tabletLayoutBody,
    this.mobileLayoutBody,
    this.useLayout = true,
    this.removePadding = false,
  });

  //layouts body according to differant platforms
  final Widget? desktopLayoutBody;
  final Widget? tabletLayoutBody;
  final Widget? mobileLayoutBody;
  final bool removePadding;

  //flag which check if using layout or not
  final bool useLayout;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayOut(
      desktopLayout: useLayout
          ? DesktopLayout(
              body: desktopLayoutBody,
              removePadding: removePadding,
            )
          : desktopLayoutBody ?? const SizedBox(),
      tabletLayout: useLayout
          ? TabletLayout(
              body: tabletLayoutBody ?? desktopLayoutBody,
              removePadding: removePadding,
            )
          : tabletLayoutBody ?? desktopLayoutBody!,
      mobileLayout: useLayout
          ? MobileLayout(
              body: mobileLayoutBody ?? desktopLayoutBody,
              removePadding: removePadding,
            )
          : mobileLayoutBody ?? desktopLayoutBody!,
    );
  }
}
