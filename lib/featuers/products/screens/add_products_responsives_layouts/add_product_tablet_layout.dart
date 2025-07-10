import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/containers/rounded_container.dart';
import 'package:ushop_web/data/controllers/brands/brands_controller.dart';
import 'package:ushop_web/data/controllers/category/category_controller.dart';
import 'package:ushop_web/featuers/media/controllers/media_controller.dart';
import 'package:ushop_web/featuers/products/controllers/add_product_controller.dart';
import 'package:ushop_web/featuers/products/widgets/add_product_bottom_sheet.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import '../../widgets/add_additional_product_images.dart';
import '../../widgets/add_product_thumbnile.dart';
import '../../widgets/product_attributes_card.dart';
import '../../widgets/product_attributes_list.dart';
import '../../widgets/product_basic_information.dart';
import '../../widgets/product_stock_and_pricing.dart';
import '../../widgets/product_variations.dart';
import '../../widgets/product_visibilty_field.dart';
import '../../widgets/select_product_brand_dropdown.dart';
import '../../widgets/select_product_category_field.dart';

class AddProductTabletLayout extends StatelessWidget {
  const AddProductTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    final BrandsController brandsController = Get.put(BrandsController());
    Get.put(AddProductController());
    Get.put(CategoryController());
    brandsController.fatchBrands();
    controller.isDragZoneShowen.value = true;
    return Scaffold(
      bottomNavigationBar: const AddProductBottomSheet(),
      body: Form(
        key: AddProductController.formKey,
        child: const SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            children: [
              ProductBasicInformation(),

              //space
              SizedBox(height: AppSizes.md),

              //product stock & pricing inputs
              RoundedContainer(
                child: Column(
                  children: [
                    SizedBox(height: AppSizes.sm),

                    //product stock & pricing card
                    ProductStockAndPricing(),

                    //space
                    SizedBox(height: AppSizes.md),

                    //product attributes card
                    ProductAttributesCard(),
                    //space
                    SizedBox(height: AppSizes.md),

                    //product attributes list
                    ProductAttributesList(),
                  ],
                ),
              ),

              //space
              SizedBox(height: AppSizes.md),
              ProductVariations(),

              //horizontal space
              SizedBox(height: AppSizes.md),

              //order status chart
              AddProductThumbnile(),

              //space
              SizedBox(height: AppSizes.md),

              //add aditional product images
              AddAdditionalProductsImages(),

              //space
              SizedBox(height: AppSizes.md),

              //select product brand dropdown
              SelectProductBrandDropdown(),

              //space
              SizedBox(height: AppSizes.md),

              //select product category
              SelectProductCategoryField(),

              //space
              SizedBox(height: AppSizes.md),

              //select product visibility
              ProductVisibiltyField(),
            ],
          ),
        ),
      ),
    );
  }
}
