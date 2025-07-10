import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/tables/table_search_bar.dart';
import '../controllers/products_table_controller.dart';

class ProductsSearchBar extends StatelessWidget {
  const ProductsSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProductsTableController productsTableController = Get.find<ProductsTableController>();
    return Obx(
      () => TableSearchBar(
        controller: productsTableController.searchController.value,
        onChanged: (value) async {
          await productsTableController.searchProducts();
        },
      ),
    );
  }
}
