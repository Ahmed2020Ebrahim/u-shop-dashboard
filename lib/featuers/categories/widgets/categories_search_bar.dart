import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/featuers/categories/controllers/categories_table_controller.dart';
import '../../../common/widgets/tables/table_search_bar.dart';

class CategoriesSearchBar extends StatelessWidget {
  const CategoriesSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CategoriesTableController categoriesTableController = Get.find();
    return Obx(
      () => TableSearchBar(
        controller: categoriesTableController.searchController.value,
        onChanged: (value) async {
          await categoriesTableController.searchCategory();
        },
      ),
    );
  }
}
