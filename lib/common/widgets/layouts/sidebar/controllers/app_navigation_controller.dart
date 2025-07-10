import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;
import 'package:ushop_web/routes/app_routs.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';

class AppNavigationController extends GetxController {
  // Singleton pattern to ensure only one instance of AppNavigationController exists
  static AppNavigationController get instance => Get.find();

  //active item
  final activeItem = AppRouts.dashboard.obs;

  //hover item
  final hoverItem = "".obs;

  //currentrout
  final currentRout = AppRouts.dashboard.obs;

  //route segments
  final RxList<String> routeSegments = <String>[].obs;

  @override
  void onInit() {
    // Handle deep linking
    final uri = Uri.parse(Get.currentRoute);
    if (uri.pathSegments.isNotEmpty) {
      activeItem.value = "/${uri.pathSegments[0]}";
    } else {
      activeItem.value = AppRouts.dashboard;
    }
    html.window.history.pushState(null, '', activeItem.value);
    super.onInit();
  }

  //change active item
  void changeActiveItem(String route) {
    final firstRoutSegment = getFirstRouteSegment(route);
    activeItem.value = firstRoutSegment;
  }

  //change hover item
  void changeHoverItem(String route) {
    if (!(isActive(route))) {
      hoverItem.value = route;
    }
  }

  //is active
  bool isActive(String route) {
    final firstRoutSegment = getFirstRouteSegment(route);
    if (activeItem.value == firstRoutSegment) {
      return true;
    } else {
      return false;
    }
  }

  //get previous navigation
  String getPreviousNavigation(List<String> segments) {
    if (segments.length > 1) {
      final previousSegments = segments.sublist(0, segments.length - 1);
      return "/${previousSegments.join('/')}";
    } else {
      return AppRouts.dashboard;
    }
  }

  //is hover
  bool isHover(String route) => hoverItem.value == route;

  //on item tap
  void appNavigate(String route) {
    //change current route
    currentRout.value = route;
    //change route segments
    routeSegments.value = getRouteSegments(route);
    //change active item
    changeActiveItem(route);

    //hide drawer if the screen is mobile or tablet
    if (HelperFunctions.isMobileScreen(Get.context!) || HelperFunctions.isTabletScreen(Get.context!)) Get.back();

    html.window.history.pushState(null, 'Title', route);
  }

  //state check
  bool? stateCheck(route) {
    if (isActive(route)) {
      return true;
    } else if (isHover(route) && !isActive(route)) {
      return false;
    } else {
      return null;
    }
  }

  //get last rout segment
  String getLastRouteSegment(String route) {
    final segments = route.split('/').where((e) => e.isNotEmpty).toList();
    return segments.isNotEmpty ? segments.last : '';
  }

  //get first rout segment
  String getFirstRouteSegment(String route) {
    final segments = route.split('/').where((e) => e.isNotEmpty).toList();
    return segments.isNotEmpty ? '/${segments.first}' : '/';
  }

  //get route segments
  List<String> getRouteSegments(String route) {
    return route.split('/').where((segment) => segment.isNotEmpty).toList();
  }
}
