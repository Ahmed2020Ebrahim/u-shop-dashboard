import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../../../data/controllers/order/order_controller.dart';
import '../../../data/models/order/order_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class OrderTotalAmountDetails extends StatelessWidget {
  const OrderTotalAmountDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find();
    OrderModel order = orderController.currentOrder.value;
    return RoundedContainer(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.md),
      color: AppColors.softGrey,
      child: Column(
        children: [
          //subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Subtotal"),
              Text("\$${order.getOrderSubtotal.toStringAsFixed(2)}"),
            ],
          ),
          //space
          const SizedBox(height: AppSizes.sm),
          //discount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Discount"),
              Text("\$${orderController.calculateDiscount(order.orderTotalAmount, order.getOrderSubtotal).toStringAsFixed(2)}"),
            ],
          ),
          //space
          const SizedBox(height: AppSizes.sm),
          //shippig
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Shipping"),
              Text("\$${orderController.calculateShippingFeePrice(order.getOrderSubtotal).toStringAsFixed(2)}"),
            ],
          ),
          //space
          const SizedBox(height: AppSizes.sm),
          //Tax
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tax"),
              Text("\$${orderController.calculateTaxFeePrice(order.getOrderSubtotal).toStringAsFixed(2)}"),
            ],
          ),
          //space
          const SizedBox(height: AppSizes.md),
          const Divider(),
          //total amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Amount", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("\$${order.orderTotalAmount.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
