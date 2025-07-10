import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/featuers/customers/controllers/customers_table_controller.dart';
import '../../../common/widgets/tables/table_search_bar.dart';

class CustomersSearchbar extends StatelessWidget {
  const CustomersSearchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CustomersTableController customersTableController = Get.find();
    return Obx(
      () => TableSearchBar(
        controller: customersTableController.searchController.value,
        onChanged: (value) async {
          await customersTableController.searchUsers();
        },
      ),
    );
  }
}
