import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/data/models/category/category_model.dart';
import 'package:ushop_web/featuers/categories/controllers/categories_table_controller.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

import '../../../common/widgets/dialogs/dialoges.dart';
import '../../../common/widgets/tables/generic_data_table_source.dart';
import '../../../common/widgets/tables/generic_table_widget.dart';

class CategoriesTable extends StatelessWidget {
  const CategoriesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoriesTableController categoriesTableController = Get.find();

    return Obx(
      () => Expanded(
        child: GenericTableWidget(
          sortAscending: categoriesTableController.isSortingAssinding.value,
          sortColumnIndex: 0,
          columns: [
            dataColumnBuilder(categoriesTableController, "name", "Category"),
            const DataColumn2(label: Text("Parent Category")),
            const DataColumn2(label: Text("Is Featured")),
            const DataColumn2(label: Text("Date")),
            const DataColumn2(
              label: Padding(padding: EdgeInsets.only(right: AppSizes.lg * 2 - 5), child: Text("Actions")),
              headingRowAlignment: MainAxisAlignment.end,
            ),
          ],
          source: GenericDataTableSource<CategoryModel>(
            items: categoriesTableController.filteredCategories,
            onTap: (index) {},
            onDelet: (index) {
              Dialoges.showDefaultDialog(context: Get.context!, title: "Delet Category?", contant: const Text('Do you want to delet this category?'), actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("cancel"),
                ),
                TextButton(
                  onPressed: () {
                    categoriesTableController.removeCategory(index);
                    Get.back();
                  },
                  child: const Text("Delet", style: TextStyle(color: Colors.red)),
                ),
              ]);
            },
            onEdit: (index) {
              categoriesTableController.onEditCategory(index);
            },
          ),
        ),
      ),
    );
  }

  DataColumn2 dataColumnBuilder(CategoriesTableController controller, String orderby, String label) {
    return DataColumn2(
      label: Row(
        children: [
          Text(label),
          IconButton(
            onPressed: () {
              controller.reOrderCategories(orderby, !controller.isSortingAssinding.value);
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
