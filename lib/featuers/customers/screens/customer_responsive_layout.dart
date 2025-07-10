import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/controllers/user/user_controller.dart';
import 'package:ushop_web/featuers/customers/controllers/customers_table_controller.dart';
import 'package:ushop_web/featuers/customers/widgets/customers_searchbar.dart';
import 'package:ushop_web/featuers/customers/widgets/customers_table.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CustomerResponsiveLayout extends StatelessWidget {
  const CustomerResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final CustomersTableController custmersTableController = Get.put(CustomersTableController());

    return Scaffold(
      body: Column(
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomersSearchbar(),
            ],
          ),

          //space
          const SizedBox(height: AppSizes.md),
          Obx(
            () {
              if (custmersTableController.isLoading.value) {
                return const Expanded(
                  child: RoundedContainer(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (custmersTableController.filteredUsers.isNotEmpty) {
                return const CustomersTable();
              } else {
                return const Expanded(
                  child: RoundedContainer(
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: Text(
                      "No results found",
                      style: TextStyle(fontSize: 18, color: AppColors.darkGrey),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
