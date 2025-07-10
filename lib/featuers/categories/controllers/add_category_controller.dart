import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/dialogs/dialoges.dart';
import 'package:ushop_web/data/controllers/category/category_controller.dart';
import 'package:ushop_web/data/models/image/image_model.dart';
import 'package:ushop_web/utils/popups/app_popups.dart';

import '../../../data/models/category/category_model.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../media/controllers/media_controller.dart';

class AddCategoryController extends GetxController {
  //instance
  static AddCategoryController get instance => Get.find();

  //category controller
  final CategoryController categoryController = Get.find();

  //media controller
  final MediaController mediaController = Get.put(MediaController());

  //texteditingcontrollers
  final TextEditingController nameController = TextEditingController();

  //form key
  final formKey = GlobalKey<FormState>();

  //current category
  final Rx<CategoryModel> currentCategory = CategoryModel.emptyCategoryModel().obs;

  //parent category
  final Rx<String> parentCategoryId = "".obs;

  //category image
  final Rx<ImageModel> categoryImage = ImageModel.empty().obs;

  //isupdate
  final RxBool isUpdate = false.obs;

  //isfeatured
  final RxBool isFeatured = false.obs;

  //change is fatured
  void changeIsFeatured(bool value) {
    isFeatured.value = value;
  }

  //set parent category
  void setParentCategory(String? id) {
    if (id != null && id.isNotEmpty) {
      parentCategoryId.value = id;
    }
  }

  //clear values
  void clearValues() {
    nameController.clear();
    categoryImage.value = ImageModel.empty();
    isFeatured.value = false;
    parentCategoryId.value = "";
    currentCategory.value = CategoryModel.emptyCategoryModel();
    isUpdate.value = false;
    currentCategory.refresh();
  }

  //setvalues
  void setValuesToUpdate(CategoryModel category) {
    nameController.text = category.name;
    categoryImage.value = ImageModel(mime: "", url: category.image, folder: "", fileName: '');
    isFeatured.value = category.isFeatured;
    parentCategoryId.value = category.parentId;
    currentCategory.value = category;
    isUpdate.value = true;
    currentCategory.refresh();
  }

  //select image
  Future<void> selectCategoryImage() async {
    //open media screen bottom sheet
    //open the media screen and chose image and set it to the current controller image
    MediaController.instance.resetValues(true);
    final data = await mediaController.showSelectProductImagesBottomSheet(
      selectable: true,
      multiSelectable: false,
      folder: categoryImage.value.mediaCategory.isEmpty ? null : HelperFunctions.getMediaDropdownSectonsFromString(categoryImage.value.mediaCategory),
      selectedImages: categoryImage.value.url.isEmpty ? null : [categoryImage.value],
    );

    if (data != null && data.isNotEmpty) {
      categoryImage.value = data.first;
    } else {
      categoryImage.value = ImageModel.empty();
    }
    categoryImage.refresh();
  }

  //create category
  Future<void> createCategory() async {
    if (_validation()) {
      Dialoges.showDefaultDialog(
          context: Get.context!,
          title: "Create Category",
          contant: const Text(
            'Do you want to create this category?',
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
                await _uploadCategory().then(
                  (value) {
                    nameController.clear();
                    categoryImage.value = ImageModel.empty();
                    isFeatured.value = false;
                    parentCategoryId.value = "";
                  },
                );
              },
              child: const Text("Create"),
            ),
          ]);
    }
  }

  //edit category
  Future<void> editCategory() async {
    if (_validation()) {
      Dialoges.showDefaultDialog(
          context: Get.context!,
          title: "Create Category",
          contant: const Text(
            'Do you want to create this category?',
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
                await _updateCategory().then(
                  (value) {
                    nameController.clear();
                    categoryImage.value = ImageModel.empty();
                    isFeatured.value = false;
                    parentCategoryId.value = "";
                  },
                );
              },
              child: const Text("update"),
            ),
          ]);
    }
  }

  //validation
  bool _validation() {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    //parent category validation
    if (parentCategoryId.value.isEmpty) {
      AppPopups.showWarningToast(msg: "Parent category is required");

      return false;
    }

    //check image
    if (categoryImage.value.url.isEmpty) {
      AppPopups.showWarningToast(msg: 'Image is required');
      return false;
    }

    return true;
  }

  //update category
  Future<void> _updateCategory() async {
    Get.back();
    currentCategory.value = CategoryModel(
      id: currentCategory.value.id,
      name: nameController.text,
      image: categoryImage.value.url,
      isFeatured: isFeatured.value,
      parentId: parentCategoryId.value,
      subCategories: [],
    );
    await categoryController.updateCategory(currentCategory.value);
  }

  //upload category
  Future<void> _uploadCategory() async {
    Get.back();
    //create randomid

    currentCategory.value = CategoryModel(
      id: "",
      name: nameController.text,
      image: categoryImage.value.url,
      isFeatured: isFeatured.value,
      parentId: parentCategoryId.value,
      subCategories: [],
    );
    await categoryController.createCategory(currentCategory.value);
  }
}
