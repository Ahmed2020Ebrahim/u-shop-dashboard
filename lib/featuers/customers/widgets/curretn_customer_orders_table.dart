import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../dashboard/widgets/order_status_table.dart';
import '../controllers/customer_controller.dart';
import 'customer_order_search_bar.dart';

class CurrentCustomerOrdersTable extends StatelessWidget {
  const CurrentCustomerOrdersTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomerController customerController = Get.find();

    return RoundedContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSizes.md, AppSizes.md, AppSizes.md, AppSizes.sm),
            child: Row(
              children: [
                //title
                Text("Orders", style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Totel spends ',
                        style: TextStyle(color: AppColors.black),
                      ),
                      TextSpan(
                        text: '\$${customerController.calculateTotal()} ',
                        style: const TextStyle(color: AppColors.primary),
                      ),
                      const TextSpan(
                        text: 'in ',
                        style: TextStyle(color: AppColors.black),
                      ),
                      TextSpan(
                        text: '${customerController.currentUserOrders.length} ',
                        style: const TextStyle(color: AppColors.primary),
                      ),
                      const TextSpan(
                        text: 'orders ',
                        style: TextStyle(color: AppColors.black),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          //search bar
          const CustomerOrderSearchBar(),
          SizedBox(
            height: 420,
            child: OrdersStatusTable(ordersList: customerController.filteredOrders),
          ),
        ],
      ),
    );
  }
}
