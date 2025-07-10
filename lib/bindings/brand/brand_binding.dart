import 'package:get/get.dart';
import 'package:ushop_web/data/controllers/brands/brands_controller.dart';

class BrandBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandsController>(() => BrandsController(), fenix: true);
  }
}
