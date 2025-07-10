import 'package:get/get.dart';
import 'package:ushop_web/data/controllers/products/products_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
  }
}
