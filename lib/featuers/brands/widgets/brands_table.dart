import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/data/models/brand/brand_model.dart';
import 'package:ushop_web/featuers/brands/controllers/brands_table_controller.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

import '../../../common/widgets/dialogs/dialoges.dart';
import '../../../common/widgets/tables/generic_data_table_source.dart';
import '../../../common/widgets/tables/generic_table_widget.dart';

class BrandsTable extends StatelessWidget {
  const BrandsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final BrandsTableController brandsTableController = Get.find();

    return Obx(
      () => Expanded(
        child: GenericTableWidget(
          sortAscending: brandsTableController.isSortingAssinding.value,
          sortColumnIndex: 0,
          columns: [
            dataColumnBuilder(brandsTableController, "name", "Brand"),
            const DataColumn2(label: Text("Items")),
            const DataColumn2(label: Text("Featured")),
            const DataColumn2(label: Text("Date")),
            const DataColumn2(
              label: Padding(padding: EdgeInsets.only(right: AppSizes.lg * 2 - 5), child: Text("Actions")),
              headingRowAlignment: MainAxisAlignment.end,
            ),
          ],
          source: GenericDataTableSource<BrandModel>(
            items: brandsTableController.filteredbrands,
            onTap: (index) {},
            onEdit: (index) async {
              await brandsTableController.onEditBrand(index);
            },
            onDelet: (index) async {
              Dialoges.showDefaultDialog(context: Get.context!, title: "Delet Brand?", contant: const Text('Do you want to delet this brand?'), actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("cancel"),
                ),
                TextButton(
                  onPressed: () {
                    //remove brand
                    brandsTableController.removeBrand(index);
                    Get.back();
                  },
                  child: const Text("Delet", style: TextStyle(color: Colors.red)),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }

  DataColumn2 dataColumnBuilder(BrandsTableController controller, String orderby, String label) {
    return DataColumn2(
      label: Row(
        children: [
          Text(label),
          IconButton(
            onPressed: () {
              controller.reOrderBrands(orderby, !controller.isSortingAssinding.value);
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
