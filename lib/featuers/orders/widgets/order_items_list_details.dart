import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/cards/custome_titled_card.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../common/widgets/images/custom_image.dart';
import '../../../data/controllers/order/order_controller.dart';
import '../../../data/models/order/order_model.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import 'order_total_amount_details.dart';

class OrderItemsListDetails extends StatelessWidget {
  const OrderItemsListDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find();
    OrderModel order = orderController.currentOrder.value;
    return RoundedContainer(
      width: double.infinity,
      child: CustomeTiteledCard(
        title: "Items",
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm, vertical: AppSizes.md),
          child: Column(
            children: [
              //listtails for all items
              ...order.items.map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RoundedContainer(
                                width: 60,
                                height: 60,
                                child: CustomImage(
                                  imagePath: e.image,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.fill,
                                  imageType: ImageType.network,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: AppSizes.md),
                              Flexible(
                                child: Text(
                                  e.title,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("\$${e.price.toString()}"),
                              const SizedBox(width: AppSizes.sm),
                              Text("${e.quantity}"),
                              const SizedBox(width: AppSizes.md),
                              Text("\$${e.price * e.quantity}"),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              //space
              const SizedBox(height: AppSizes.md),
              //total amount
              const OrderTotalAmountDetails(),
              //space
              const SizedBox(height: AppSizes.md),
            ],
          ),
        ),
      ),
    );
  }
}
