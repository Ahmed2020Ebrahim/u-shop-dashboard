import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/data/models/user/user_model.dart';
import 'package:ushop_web/featuers/customers/controllers/customer_controller.dart';
import 'package:ushop_web/featuers/customers/controllers/customers_table_controller.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

import '../../../common/widgets/tables/generic_data_table_source.dart';
import '../../../common/widgets/tables/generic_table_widget.dart';

class CustomersTable extends StatelessWidget {
  const CustomersTable({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CustomerController());
    final CustomersTableController customersTableController = Get.find();

    return Obx(
      () => Expanded(
        child: GenericTableWidget(
          sortAscending: customersTableController.isSortingAssinding.value,
          sortColumnIndex: 0,
          columns: [
            dataColumnBuilder(customersTableController, "name", "Customer"),
            const DataColumn2(label: Text("E-mail")),
            const DataColumn2(label: Text("Phone")),
            const DataColumn2(label: Text("Regestered")),
            const DataColumn2(
              label: Padding(padding: EdgeInsets.only(right: AppSizes.lg * 2 - 5), child: Text("Actions")),
              headingRowAlignment: MainAxisAlignment.end,
            ),
          ],
          source: GenericDataTableSource<UserModel>(
            items: customersTableController.filteredUsers,
            onTap: (index) {},
            onEdit: (index) async {
              await customersTableController.onShow(index);
            },
          ),
        ),
      ),
    );
  }

  DataColumn2 dataColumnBuilder(CustomersTableController controller, String orderby, String label) {
    return DataColumn2(
      label: Row(
        children: [
          Text(label),
          IconButton(
            onPressed: () {
              controller.reOrderCustomers(orderby, !controller.isSortingAssinding.value);
            },
            icon: Icon(
              controller.isSortingAssinding.value ? Iconsax.arrow_3 : Iconsax.arrow_down,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
