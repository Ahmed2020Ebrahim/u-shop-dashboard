import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../common/widgets/images/custom_image.dart';
import '../../../data/controllers/order/order_controller.dart';
import '../../../data/models/order/order_model.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'order_basic_information_item.dart';

class OrderTransactionCard extends StatelessWidget {
  const OrderTransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find();
    OrderModel order = orderController.currentOrder.value;
    return RoundedContainer(
      width: double.infinity,
      child: CustomeTiteledCard(
        title: "Transactios",
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CustomImage(
                      imagePath: HelperFunctions.getPaymentMethodImage(HelperFunctions.getPaymentMethodFromString(order.paymentMethod)),
                      width: 60,
                      height: 60,
                      imageType: ImageType.asset,
                      borderRadius: BorderRadius.circular(8),
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      "Payment Via ${order.paymentMethod}",
                    ),
                    subtitle: Text("Paypal fee  \$${orderController.calculatePaymentMethodFee(order.paymentMethod, order.orderTotalAmount).toStringAsFixed(2)} "),
                  ),
                ],
              ),
            ),
            OrderBasicInformationItem(
              label: "Date",
              child: Text(
                HelperFunctions.getFormattedDate(order.orderDate),
              ),
            ),
            OrderBasicInformationItem(
              label: "Total",
              child: Text(order.orderTotalAmount.toStringAsFixed(2)),
            ),
          ],
        ),
      ),
    );
  }
}
