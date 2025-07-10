import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

import '../../../common/widgets/dialogs/dialoges.dart';
import '../../../common/widgets/tables/generic_data_table_source.dart';
import '../../../common/widgets/tables/generic_table_widget.dart';
import '../../../data/models/products/product_model.dart';
import '../controllers/products_table_controller.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsTableController productsTableController = Get.find();

    return Obx(
      () => Expanded(
        child: GenericTableWidget(
          sortAscending: productsTableController.sortAscending[productsTableController.selectedSortingValue.value]!,
          columns: [
            dataColumnBuilder(productsTableController, "name", "Product"),
            const DataColumn2(label: Text("Image")),
            dataColumnBuilder(productsTableController, "stock", "Stock"),
            dataColumnBuilder(productsTableController, "brand", "Brand"),
            dataColumnBuilder(productsTableController, "price", "Price"),
            const DataColumn2(label: Text("Date")),
            const DataColumn2(
              label: Padding(padding: EdgeInsets.only(right: AppSizes.lg * 2 - 5), child: Text("Actions")),
              headingRowAlignment: MainAxisAlignment.end,
            ),
          ],
          source: GenericDataTableSource<Product>(
            items: productsTableController.filteredProducts,
            onTap: (index) {},
            onEdit: (index) async {
              await productsTableController.onEditProduct(index);
            },
            onDelet: (index) {
              Dialoges.showDefaultDialog(context: Get.context!, title: "Delet Product?", contant: const Text('Do you want to delet this product?'), actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("cancel"),
                ),
                TextButton(
                  onPressed: () {
                    productsTableController.removeProduct(index);
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

  DataColumn2 dataColumnBuilder(ProductsTableController productsTableController, String orderby, String label) {
    return DataColumn2(
      label: Row(
        children: [
          Text(label),
          IconButton(
            onPressed: () {
              productsTableController.reOrderProducts(orderby, !productsTableController.sortAscending[orderby]!);
            },
            icon: Icon(
              productsTableController.sortAscending[orderby]! ? Iconsax.arrow_down : Iconsax.arrow_3,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
