import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/data/controllers/products/products_controller.dart';
import 'package:ushop_web/routes/app_routs.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import 'package:ushop_web/utils/helpers/helper_functions.dart';
import '../../../common/widgets/buttons/app_primary_button.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../controllers/add_product_controller.dart';
import '../controllers/products_table_controller.dart';
import '../widgets/products_search_bar.dart';
import '../widgets/products_table.dart';

class ProductsResponsiveLayout extends StatelessWidget {
  const ProductsResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddProductController());
    Get.put(ProductController());
    final ProductsTableController productsTableController = Get.put(ProductsTableController());
    final AppNavigationController appNavigationController = Get.find();

    return Scaffold(
      body: Column(
        children: [
          //search bar
          // This search bar is used to search products by name
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppPrimaryButton(
                label: 'Add New Product',
                onTap: () {
                  AddProductController.instance.clearAllData();
                  appNavigationController.appNavigate(HelperFunctions.capitalizeFirst(AppRouts.addProduct));
                },
                icon: const Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
              const ProductsSearchBar(),
            ],
          ),

          //space
          const SizedBox(height: AppSizes.md),

          // products table
          // This table displays the products with their details
          // It uses the ProductsTableController to manage the data and sorting
          Obx(
            () {
              if (productsTableController.isLoading.value) {
                // Show a loading indicator while products are being fetched
                return const Expanded(
                  child: RoundedContainer(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  ),
                );
                // If there are no products, show a message
              } else if (productsTableController.filteredProducts.isNotEmpty) {
                return const ProductsTable();
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
