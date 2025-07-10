import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/controllers/brands/brands_controller.dart';
import 'package:ushop_web/data/models/brand/brand_model.dart';
import 'package:ushop_web/data/models/category/category_model.dart';
import 'package:ushop_web/data/models/image/image_model.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import 'package:ushop_web/utils/popups/app_popups.dart';

import '../../../common/widgets/dialogs/dialoges.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../media/controllers/media_controller.dart';

class AddBrandController extends GetxController {
  //instance
  static AddBrandController get instance => Get.find();

  //media controller
  final MediaController _mediaController = Get.put(MediaController());

  //brandcontroller
  final BrandsController _brandController = Get.put(BrandsController());

  //currentBrand
  final Rx<BrandModel> currentBrand = BrandModel.emptyBrandModel().obs;

  //formkey
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //newbrandname texteditcontroller
  final TextEditingController newBrandNameController = TextEditingController();

  //categories list
  final RxList<String> selectedCategoriesIds = <String>[].obs;

  //selected image
  final Rx<ImageModel> selectedImage = ImageModel.empty().obs;

  //is featured
  final RxBool isFeatured = false.obs;
  //isUpdate
  final RxBool isUpdate = false.obs;

  //onCategorySelected
  void onCategorySelected(CategoryModel category) {
    //check by id
    if (selectedCategoriesIds.contains(category.id)) {
      selectedCategoriesIds.removeWhere((id) => id == category.id);
      selectedCategoriesIds.refresh();
    } else {
      selectedCategoriesIds.add(category.id);
      selectedCategoriesIds.refresh();
    }
  }

  //isCategorySelected
  bool isCategorySelected(String id) {
    return selectedCategoriesIds.contains(id);
  }

  //onSelectImage
  //select image
  Future<void> selectBrandImage() async {
    //open media screen bottom sheet
    //open the media screen and chose image and set it to the current controller image
    _mediaController.resetValues(true);
    final data = await _mediaController.showSelectProductImagesBottomSheet(
      selectable: true,
      multiSelectable: false,
      folder: selectedImage.value.mediaCategory.isEmpty ? MediaDropdownSectons.brands : HelperFunctions.getMediaDropdownSectonsFromString(selectedImage.value.mediaCategory),
      selectedImages: selectedImage.value.url.isEmpty ? null : [selectedImage.value],
    );

    if (data != null && data.isNotEmpty) {
      selectedImage.value = data.first;
    } else {
      selectedImage.value = ImageModel.empty();
    }
    selectedImage.refresh();
  }

  //onFeaturedChanged
  void onFeaturedChanged(bool value) {
    isFeatured.value = value;
  }

  //validateAndUpload
  //create brand
  Future<void> createBrand() async {
    if (_validate()) {
      Dialoges.showDefaultDialog(
          context: Get.context!,
          title: "Create Brand",
          contant: const Text(
            'Do you want to create this Brand?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("cancel"),
            ),
            TextButton(
              onPressed: () async {
                await _uploadBrand().then(
                  (value) {
                    clearData();
                  },
                );
              },
              child: const Text("Create"),
            ),
          ]);
    }
  }

  //validateAndUpdate

  //edit brand
  Future<void> editBrand() async {
    if (_validate()) {
      Dialoges.showDefaultDialog(
          context: Get.context!,
          title: "Create Brand",
          contant: const Text(
            'Do you want to create this brand?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("cancel"),
            ),
            TextButton(
              onPressed: () async {
                await _updateBrand().then(
                  (value) {
                    clearData();
                  },
                );
              },
              child: const Text("update"),
            ),
          ]);
    }
  }

  //clearData
  void clearData() {
    isUpdate.value = false;
    newBrandNameController.clear();
    selectedCategoriesIds.value = [];
    selectedCategoriesIds.refresh();
    selectedImage.value = ImageModel.empty();
    isFeatured.value = false;
    currentBrand.value = BrandModel.emptyBrandModel();
    selectedCategoriesIds.refresh();
    selectedImage.refresh();
    isFeatured.refresh();
  }

  //setDataToUpdate
  void setDataToUpdate(BrandModel brand) {
    isUpdate.value = true;
    currentBrand.value = brand;
    newBrandNameController.text = brand.name;
    selectedImage.value = ImageModel(mime: "", url: brand.imageUrl, folder: "", fileName: '');
    isFeatured.value = brand.isFeatured;
    selectedCategoriesIds.value = brand.brandCategoriesIds ?? [];
    selectedCategoriesIds.refresh();
    selectedImage.refresh();
    isFeatured.refresh();
  }

  //_validate
  bool _validate() {
    if (!formKey.currentState!.validate()) {
      AppPopups.showWarningToast(msg: "Brand name is required");
      return false;
    }
    if (selectedCategoriesIds.isEmpty) {
      AppPopups.showWarningToast(msg: "Select at least one category");
      return false;
    }
    if (selectedImage.value.url.isEmpty) {
      AppPopups.showWarningToast(msg: "Select an image");
      return false;
    }
    return true;
  }

  //upload category
  Future<void> _uploadBrand() async {
    Get.back();
    currentBrand.value = BrandModel(
      id: "",
      name: newBrandNameController.text,
      productsCount: 0,
      imageUrl: selectedImage.value.url,
      isFeatured: isFeatured.value,
      brandCategoriesIds: selectedCategoriesIds,
    );
    await _brandController.createBrand(currentBrand.value);
  }

  //update brand
  Future<void> _updateBrand() async {
    Get.back();
    currentBrand.value = BrandModel(
      id: currentBrand.value.id,
      name: newBrandNameController.text,
      productsCount: currentBrand.value.productsCount,
      imageUrl: currentBrand.value.imageUrl,
      isFeatured: currentBrand.value.isFeatured,
      brandCategoriesIds: selectedCategoriesIds,
    );

    await _brandController.updateBrand(currentBrand.value);
  }
}
