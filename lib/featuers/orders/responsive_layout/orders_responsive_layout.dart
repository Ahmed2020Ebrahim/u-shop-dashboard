import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/containers/rounded_container.dart';
import 'package:ushop_web/data/controllers/order/order_controller.dart';
import 'package:ushop_web/featuers/dashboard/controllers/orders_table_controller.dart';
import 'package:ushop_web/featuers/dashboard/widgets/order_status_table.dart';
import 'package:ushop_web/featuers/orders/widgets/order_search_bar.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';

class OrdersResponsiveLayout extends StatelessWidget {
  const OrdersResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());
    final OrdersTableController ordersTableController = Get.put(OrdersTableController());

    return Scaffold(
      body: Column(
        children: [
          //order search bar
          const OrderSearchBar(),
          //space
          const SizedBox(height: AppSizes.md),
          Obx(
            () {
              if (ordersTableController.isLoading.value) {
                return const Expanded(
                  child: RoundedContainer(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (ordersTableController.filteredOrders.isNotEmpty) {
                return const Expanded(
                  child: OrdersStatusTable(
                    hasActions: true,
                    hasSearchBar: true,
                    rowsPerPage: 8,
                  ),
                );
              } else {
                return const Expanded(
                  child: RoundedContainer(
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: Text(
                      "No results found",
                      style: TextStyle(fontSize: 18, color: AppColors.darkGrey),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
