//variaton cotroller
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/image/image_model.dart';
import '../../../utils/constants/enums.dart';

class VariationControllers {
  final TextEditingController priceController;
  final TextEditingController stockController;
  final TextEditingController discountController;
  final TextEditingController descriptionController;
  final Rx<ImageModel> image = ImageModel.empty().obs;
  final Rx<MediaDropdownSectons> folder = MediaDropdownSectons.folders.obs;
  final RxBool isImageSelected = true.obs;

  VariationControllers({
    required this.priceController,
    required this.stockController,
    required this.discountController,
    required this.descriptionController,
  });
}
