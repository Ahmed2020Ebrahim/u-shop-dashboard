import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/utils/helpers/network_manager.dart';

class GeneralBindinges extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager(), permanent: true);
    Get.put(AppNavigationController(), permanent: true);
  }
}
