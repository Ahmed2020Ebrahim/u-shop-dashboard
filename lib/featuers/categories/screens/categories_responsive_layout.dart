import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/buttons/app_primary_button.dart';
import 'package:ushop_web/data/controllers/category/category_controller.dart';
import 'package:ushop_web/featuers/categories/controllers/add_category_controller.dart';
import 'package:ushop_web/featuers/categories/controllers/categories_table_controller.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import '../../../routes/app_routs.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../widgets/categories_search_bar.dart';
import '../widgets/categories_table.dart';

class CategoriesResponsiveLayout extends StatelessWidget {
  const CategoriesResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryController());
    final CategoriesTableController categoriesTableController = Get.put(CategoriesTableController());
    Get.put(AddCategoryController());
    final AppNavigationController appNavigationController = Get.find();
    return Scaffold(
      body: Column(
        children: [
          //categories search bar
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppPrimaryButton(
                label: "Add New Category",
                onTap: () {
                  AddCategoryController.instance.clearValues();
                  appNavigationController.appNavigate(HelperFunctions.capitalizeFirst(AppRouts.addCategory));
                },
                icon: const Icon(Icons.add, color: AppColors.white),
              ),
              const CategoriesSearchBar(),
            ],
          ),

          //space
          const SizedBox(height: AppSizes.md),
          Obx(
            () {
              if (categoriesTableController.isLoading.value) {
                return const Expanded(
                  child: RoundedContainer(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (categoriesTableController.filteredCategories.isNotEmpty) {
                //return the categories table
                return const CategoriesTable();
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
