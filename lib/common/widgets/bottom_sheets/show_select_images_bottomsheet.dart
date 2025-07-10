import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/models/image/image_model.dart';

import '../../../featuers/media/screens/media_screen.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

Future<List<ImageModel>?> showSelectImagesBottomSheet() async {
  final List<ImageModel>? data = await Get.bottomSheet(
    const FractionallySizedBox(
      heightFactor: 1,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.mds),
        child: MediaScreen(),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: AppColors.bgLight,
    enterBottomSheetDuration: const Duration(milliseconds: 650),
    exitBottomSheetDuration: const Duration(milliseconds: 650),
  );
  return data ?? [];
}
