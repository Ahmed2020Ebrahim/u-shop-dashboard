import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/models/banners/banners_model.dart';
import 'package:ushop_web/featuers/bannars/controllers/bannars_table_controller.dart';
import 'package:ushop_web/utils/constants/sizes.dart';

import '../../../common/widgets/dialogs/dialoges.dart';
import '../../../common/widgets/tables/generic_data_table_source.dart';
import '../../../common/widgets/tables/generic_table_widget.dart';

class BannersTable extends StatelessWidget {
  const BannersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final BannersTableController bannersTableController = Get.find();

    return Obx(
      () => Expanded(
        child: GenericTableWidget(
          columns: const [
            DataColumn2(label: Text("Banner")),
            DataColumn2(label: Text("Target Screen")),
            DataColumn2(label: Text("Active")),
            DataColumn2(
              label: Padding(padding: EdgeInsets.only(right: AppSizes.lg * 2 - 5), child: Text("Actions")),
              headingRowAlignment: MainAxisAlignment.end,
            ),
          ],
          source: GenericDataTableSource<BannerModel>(
            items: bannersTableController.bannersList,
            onTap: (index) {},
            onEdit: (index) {
              bannersTableController.onEditBanner(index);
            },
            onDelet: (index) {
              Dialoges.showDefaultDialog(context: Get.context!, title: "Delet Banner?", contant: const Text('Do you want to delet this banner?'), actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("cancel"),
                ),
                TextButton(
                  onPressed: () {
                    //remove banner
                    bannersTableController.removeBanner(index);
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
}
