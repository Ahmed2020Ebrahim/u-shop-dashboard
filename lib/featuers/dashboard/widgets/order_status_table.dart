import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/featuers/customers/controllers/customer_controller.dart';
import 'package:ushop_web/routes/app_routs.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import '../../../common/widgets/tables/generic_data_table_source.dart';
import '../../../common/widgets/tables/generic_table_widget.dart';
import '../../../data/controllers/order/order_controller.dart';
import '../../../data/models/order/order_model.dart';
import '../../../utils/constants/colors.dart';
import '../controllers/orders_table_controller.dart';

class OrdersStatusTable extends StatelessWidget {
  const OrdersStatusTable({
    super.key,
    this.hasActions = false,
    this.hasSearchBar = false,
    this.rowsPerPage = 5,
    this.ordersList,
  });

  final bool hasActions;
  final bool hasSearchBar;
  final int rowsPerPage;
  final List<OrderModel>? ordersList;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());
    final ordersTableController = Get.put(OrdersTableController());
    final AppNavigationController appNavigationController = Get.find();
    Get.put(CustomerController());
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Obx(
        () {
          if (ordersTableController.isLoading.value) {
            // Show a loading indicator while products are being fetched
            return Container(
              margin: const EdgeInsets.only(top: 8, bottom: 20, left: 16, right: 16),
              width: double.infinity,
              height: double.infinity,
              color: AppColors.white,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
            // If there are no products, show a message
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GenericTableWidget(
                sortAscending: ordersTableController.isSortingAssinding.value,
                sortColumnIndex: 0,
                rowsPerPage: rowsPerPage,
                minWidth: 700,
                columns: [
                  dataColumnBuilder(ordersTableController, "id", "Order ID"),
                  const DataColumn2(label: Text("Date")),
                  const DataColumn2(label: Text("Items")),
                  const DataColumn2(label: Text("Status")),
                  const DataColumn2(label: Text("Amount")),
                  if (hasActions)
                    const DataColumn2(
                      label: Padding(padding: EdgeInsets.only(right: AppSizes.lg * 2 - 5), child: Text("Actions")),
                      headingRowAlignment: MainAxisAlignment.end,
                    ),
                ],
                source: GenericDataTableSource<OrderModel>(
                  items: ordersList ?? ordersTableController.filteredOrders,
                  onTap: (index) {
                    if (ordersList == null || ordersList!.isEmpty) {
                      //set current order before navigate to orderDetailsscreen
                      orderController.currentOrder.value = ordersTableController.filteredOrders[index];
                      AppNavigationController.instance.appNavigate(appNavigationController.currentRout.value + AppRouts.orderDetails);
                    } else {
                      orderController.currentOrder.value = ordersList![index];
                      AppNavigationController.instance.appNavigate(appNavigationController.currentRout.value + AppRouts.orderDetails);
                    }
                  },
                  hasActions: hasActions,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  DataColumn2 dataColumnBuilder(OrdersTableController ordersTableController, String orderby, String label) {
    return DataColumn2(
      label: Row(
        children: [
          Text(label),
          IconButton(
            onPressed: () {
              ordersTableController.reOrderOrders(orderby, !ordersTableController.isSortingAssinding.value);
            },
            icon: Icon(
              ordersTableController.isSortingAssinding.value ? Iconsax.arrow_3 : Iconsax.arrow_down,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
