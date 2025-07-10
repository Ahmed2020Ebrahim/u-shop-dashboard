import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/controllers/order/order_controller.dart';
import 'package:ushop_web/data/controllers/user/user_controller.dart';
import 'package:ushop_web/data/models/order/order_model.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../widgets/billing_address_card.dart';
import '../widgets/customer_contact_details_card.dart';
import '../widgets/order_basic_information_card.dart';
import '../widgets/order_customer_details_card.dart';
import '../widgets/order_items_list_details.dart';
import '../widgets/order_transaction_card.dart';
import '../widgets/shipping_address_card.dart';

class OrderDetailsMobileLayout extends StatelessWidget {
  const OrderDetailsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.find();
    OrderModel order = orderController.currentOrder.value;
    Get.put(UserController());
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "[ ${order.id.substring(0, 8)} ]",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary),
            ),
            //space
            const SizedBox(height: AppSizes.md),
            const Column(
              children: [
                //order information card
                OrderBasicInformationCard(),
                //space
                SizedBox(height: AppSizes.md),
                //order itmes details and its total amount details
                OrderItemsListDetails(),
                //space
                SizedBox(height: AppSizes.md),
                //Transactions
                OrderTransactionCard(),
                //space
                SizedBox(height: AppSizes.md),
                //order customer details card
                OrderCustomerDetailsCard(),
                //space
                SizedBox(height: AppSizes.md),
                //customer contacet
                CustomerContactDetailsCard(),
                //space
                SizedBox(height: AppSizes.md),
                //Shipping Address
                ShippingAddressCard(),
                //space
                SizedBox(height: AppSizes.md),
                BillingAddressCard()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
