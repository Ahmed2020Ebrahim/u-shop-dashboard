import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/featuers/customers/controllers/customer_controller.dart';
import 'package:ushop_web/featuers/customers/widgets/current_customer_shipping_address_card.dart';

import '../../../../utils/constants/sizes.dart';
import '../../widgets/curretn_customer_orders_table.dart';
import '../../widgets/customer_information_card.dart';

class CustomerDetailsMobile extends StatelessWidget {
  const CustomerDetailsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomerController());
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //customer Information card
            CustomerInformationCard(),
            //space
            SizedBox(height: AppSizes.md),
            //shipping address card
            CurrentCustomerShippingAddressCard(),
            //space
            SizedBox(height: AppSizes.md),
            //customer table
            CurrentCustomerOrdersTable()
          ],
        ),
      ),
    );
  }
}
