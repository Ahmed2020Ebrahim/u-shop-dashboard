import 'package:get/get.dart';
import 'package:ushop_web/data/controllers/order/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
  }
}
