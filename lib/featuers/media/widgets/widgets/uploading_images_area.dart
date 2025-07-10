import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/instance_manager.dart';
import 'package:ushop_web/data/models/image/image_model.dart';
import 'package:ushop_web/featuers/media/controllers/media_controller.dart';
import 'package:ushop_web/utils/logging/app_logger.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../utils/constants/app_images.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class UploadingImagesArea extends StatelessWidget {
  const UploadingImagesArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaController = Get.find<MediaController>();
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 200,
                child: DropzoneView(
                  mime: const ["image/png", "image/jpeg", "image/jpg"],
                  onCreated: (controller) {
                    mediaController.dropzoneViewController = controller;
                  },
                  cursor: CursorType.Default,
                  onDropFile: (file) async {
                    if (mediaController.allowedFiels.contains(file.type)) {
                      final byte = await mediaController.dropzoneViewController.getFileData(file);

                      final image = ImageModel(
                        mime: file.type,
                        url: "",
                        folder: "",
                        fileName: file.name,
                        localImageToUpdate: Uint8List.fromList(byte),
                        file: file,
                      );
                      mediaController.selectedImageToUpload.add(image);
                    }
                  },
                  onDropFiles: (files) {},
                  operation: DragOperation.copy,
                  onDropInvalid: (value) {},
                  onError: (value) {
                    AppLogger.error("on drag and drop error");
                  },
                  onHover: () {
                    AppLogger.error("on drag and drop hover");
                  },
                  onLeave: () {
                    AppLogger.error("on drag and drop leave");
                  },
                  onLoaded: () {
                    AppLogger.error("on drag and drop loaded");
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: RoundedContainer(
                height: 200,
                alignment: Alignment.center,
                borderColor: AppColors.darkGrey,
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: AppSizes.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        AppImages.dragAndDropIcon,
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    Text("Drag and drop Images here", style: Theme.of(context).textTheme.labelSmall),
                    const SizedBox(height: AppSizes.spaceBtwItems),
                    OutlinedButton(
                      onPressed: () async {
                        await mediaController.selectLocalImages();
                      },
                      style: OutlinedButton.styleFrom(overlayColor: Colors.red),
                      child: const Text("Select Images"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
