import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../data/controllers/order/order_controller.dart';
import '../../../data/models/order/order_model.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/formatters/app_formatters.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'order_basic_information_item.dart';

class OrderBasicInformationCard extends StatelessWidget {
  const OrderBasicInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find();
    OrderModel order = orderController.currentOrder.value;
    return RoundedContainer(
      width: double.infinity,
      child: CustomeTiteledCard(
        title: "Order Informations",
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: AppSizes.md),
          child: HelperFunctions.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OrderBasicInformationItem(
                      label: 'Date',
                      child: Text(AppFormatters.formateDate(order.orderDate), style: Theme.of(context).textTheme.titleMedium),
                    ),
                    OrderBasicInformationItem(
                      label: "Items",
                      child: Text("${order.items.length} items", style: Theme.of(context).textTheme.titleMedium),
                    ),
                    OrderBasicInformationItem(
                      label: "Status",
                      child: SizedBox(
                        width: 150,
                        child: DropdownButtonFormField(
                          iconSize: 16,
                          borderRadius: BorderRadius.circular(20),
                          value: order.orderStatus,
                          isExpanded: false,
                          isDense: true,
                          items: OrderStatus.values
                              .map(
                                (e) => DropdownMenuItem(
                                  onTap: () {},
                                  value: e,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: HelperFunctions.getOrderColor(e).withValues(alpha: 0.5),
                                    ),
                                    child: Text(
                                      HelperFunctions.capitalizeFirst(e.name),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) async {
                            //update curent order status
                            orderController.updateOrderStatus(order.userId, order.id, value!);
                          },
                        ),
                      ),
                    ),
                    OrderBasicInformationItem(
                      label: "Amount",
                      child: Text("\$${order.orderTotalAmount.toStringAsFixed(2)}", style: Theme.of(context).textTheme.titleMedium),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        OrderBasicInformationItem(
                          label: 'Date',
                          child: Text(AppFormatters.formateDate(order.orderDate), style: Theme.of(context).textTheme.titleMedium),
                        ),
                        OrderBasicInformationItem(
                          label: "Items",
                          child: Text("${order.items.length} items", style: Theme.of(context).textTheme.titleMedium),
                        ),
                      ],
                    ),
                    //space
                    const SizedBox(height: AppSizes.md),
                    Row(
                      children: [
                        OrderBasicInformationItem(
                          label: "Status",
                          child: SizedBox(
                            width: 150,
                            child: DropdownButtonFormField(
                              iconSize: 16,
                              borderRadius: BorderRadius.circular(20),
                              value: order.orderStatus,
                              isExpanded: false,
                              isDense: true,
                              items: OrderStatus.values
                                  .map(
                                    (e) => DropdownMenuItem(
                                      onTap: () {},
                                      value: e,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: HelperFunctions.getOrderColor(e).withValues(alpha: 0.5),
                                        ),
                                        child: Text(
                                          HelperFunctions.capitalizeFirst(e.name),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) async {
                                //update curent order status
                                orderController.updateOrderStatus(order.userId, order.id, value!);
                              },
                            ),
                          ),
                        ),
                        OrderBasicInformationItem(
                          label: "Amount",
                          child: Text("\$${order.orderTotalAmount.toStringAsFixed(2)}", style: Theme.of(context).textTheme.titleMedium),
                        ),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
