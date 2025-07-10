import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/featuers/customers/controllers/customer_controller.dart';
import 'package:ushop_web/featuers/customers/widgets/current_customer_shipping_address_card.dart';

import '../../../../utils/constants/sizes.dart';
import '../../widgets/curretn_customer_orders_table.dart';
import '../../widgets/customer_information_card.dart';

class CustomerDetailsDesktop extends StatelessWidget {
  const CustomerDetailsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomerController());
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //customer Information card
                        CustomerInformationCard(),
                        //space
                        SizedBox(height: AppSizes.md),
                        //shipping address card
                        CurrentCustomerShippingAddressCard(),
                        //space
                      ],
                    )),
                //space
                SizedBox(width: AppSizes.md),
                Expanded(
                  flex: 2,
                  //CurrentCustomerOrdersTable
                  child: CurrentCustomerOrdersTable(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
