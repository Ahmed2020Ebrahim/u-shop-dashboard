import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

import '../../../data/models/order/order_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

List<DataCell> orderTabelDataCells(bool hasActions, OrderModel order, {void Function()? onDelet, void Function()? onEdit}) {
  return [
    DataCell(Text(order.id.substring(0, 6).toUpperCase(), style: const TextStyle(color: AppColors.primary))),
    DataCell(Text(order.orderDate.toString().substring(0, 11))),
    DataCell(Text("${order.items.length} items")),
    DataCell(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
        width: 75,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: HelperFunctions.getOrderColor(order.orderStatus).withValues(alpha: 0.2),
        ),
        child: FittedBox(
          child: Text(
            order.orderStatus.name,
            style: TextStyle(color: HelperFunctions.getOrderColor(order.orderStatus), fontSize: 20),
          ),
        ),
      ),
    ),
    DataCell(Text("\$ ${order.orderTotalAmount.toStringAsFixed(2)}")),
    if (hasActions)
      DataCell(
        Padding(
          padding: const EdgeInsets.only(right: AppSizes.lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    onEdit!();
                  },
                  icon: const Icon(Iconsax.eye, color: AppColors.primary)),
              IconButton(
                  onPressed: () {
                    onDelet!();
                  },
                  icon: const Icon(Iconsax.trash, color: AppColors.error)),
            ],
          ),
        ),
      ),
  ];
}
