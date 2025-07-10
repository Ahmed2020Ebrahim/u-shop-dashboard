import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/featuers/customers/controllers/customer_controller.dart';
import '../../../common/widgets/tables/table_search_bar.dart';

class CustomerOrderSearchBar extends StatelessWidget {
  const CustomerOrderSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomerController customerController = Get.find<CustomerController>();
    return TableSearchBar(
      controller: customerController.searchController,
      onChanged: (value) async {
        await customerController.searchProducts();
      },
    );
  }
}
