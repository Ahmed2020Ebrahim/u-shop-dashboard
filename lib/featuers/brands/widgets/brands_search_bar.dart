import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/featuers/brands/controllers/brands_table_controller.dart';
import '../../../common/widgets/tables/table_search_bar.dart';

class BrandsSearchBar extends StatelessWidget {
  const BrandsSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BrandsTableController brandsTableController = Get.find();
    return Obx(
      () => TableSearchBar(
        controller: brandsTableController.searchController.value,
        onChanged: (value) async {
          await brandsTableController.searchBrand();
        },
      ),
    );
  }
}
