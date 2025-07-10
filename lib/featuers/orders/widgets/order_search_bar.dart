import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/featuers/dashboard/controllers/orders_table_controller.dart';
import '../../../common/widgets/tables/table_search_bar.dart';

class OrderSearchBar extends StatelessWidget {
  const OrderSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OrdersTableController ordersTableController = Get.find<OrdersTableController>();
    return Obx(
      () => TableSearchBar(
        controller: ordersTableController.searchController.value,
        onChanged: (value) async {
          await ordersTableController.searchOrder();
        },
      ),
    );
  }
}
