import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/utils/constants/sizes.dart';
import '../controllers/media_controller.dart';
import '../widgets/widgets/media_images_displayer.dart';
import '../widgets/widgets/upload_images_button.dart';
import '../widgets/widgets/uploaded_images_reviewer.dart';
import '../widgets/widgets/uploading_images_area.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key, this.isSelectable = true});

  final bool? isSelectable;

  @override
  Widget build(BuildContext context) {
    final MediaController mediaController = Get.put(MediaController());
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            //uplaod images button
            const UploadImagesButton(),

            //space
            const SizedBox(height: AppSizes.md),

            //drag and drop zone and selecting images to upload
            mediaController.isDragZoneShowen.value ? const UploadingImagesArea() : const SizedBox(),

            //space
            mediaController.isDragZoneShowen.value ? const SizedBox(height: AppSizes.md) : const SizedBox(),

            //showing uploaded image area and button to upload the mages
            mediaController.selectedImageToUpload.isEmpty ? const SizedBox() : const UploadedImagesReviewer(),

            //space
            mediaController.selectedImageToUpload.isEmpty ? const SizedBox() : const SizedBox(height: AppSizes.md),

            /// media folders displayer
            const MediaImageDisplayer(),
          ],
        ),
      ),
    );
  }
}
