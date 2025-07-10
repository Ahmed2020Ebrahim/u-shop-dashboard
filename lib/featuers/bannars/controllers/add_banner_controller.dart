import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/models/image/image_model.dart';
import 'package:ushop_web/featuers/media/controllers/media_controller.dart';
import 'package:ushop_web/utils/constants/enums.dart';

import '../../../common/widgets/dialogs/dialoges.dart';
import '../../../data/controllers/banners/banner_controller.dart';
import '../../../data/models/banners/banners_model.dart';
import '../../../utils/popups/app_popups.dart';

class AddBannerController extends GetxController {
  //instance
  static AddBannerController get instance => Get.find();

  //media screen
  final MediaController mediaController = Get.put(MediaController());

  //banner controller
  final BannerController bannerController = Get.put(BannerController());

  //image modle
  final Rx<ImageModel> currentBannerImage = ImageModel.empty().obs;

  //isActive
  final RxBool isActive = false.obs;

  //selectedPath
  final Rx<BannerActivationPathes> selectedPath = BannerActivationPathes.selectPath.obs;

  //current banner
  final Rx<BannerModel> currentBanner = BannerModel.emptyBannerModel().obs;

  //isloading
  final RxBool isLoading = false.obs;

  //isupdate
  final RxBool isUpdate = false.obs;

  //open media screen to select banner image
  Future<void> openMediaScreen() async {
    MediaController.instance.resetValues(true);
    final data = await mediaController.showSelectProductImagesBottomSheet(
      selectable: true,
      multiSelectable: false,
      folder: currentBannerImage.value.mediaCategory.isEmpty ? null : MediaDropdownSectons.bannars,
      selectedImages: currentBannerImage.value.url.isEmpty ? null : [currentBannerImage.value],
    );

    if (data != null && data.isNotEmpty) {
      currentBannerImage.value = data.first;
    } else {
      currentBannerImage.value = ImageModel.empty();
    }
    currentBannerImage.refresh();
  }

  //change isActive state
  void changeIsActive(bool value) {
    isActive.value = value;
  }

  //on BannerActivationPathes changed
  void onBannerActivationPathesChanged(BannerActivationPathes value) {
    selectedPath.value = value;
  }

  //create banner
  Future<void> createBanner() async {
    if (_validation()) {
      Dialoges.showDefaultDialog(
          context: Get.context!,
          title: "Create Banner",
          contant: const Text(
            'Do you want to create this Banner?',
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
                await _uploadBanner().then(
                  (value) {
                    currentBannerImage.value = ImageModel.empty();
                    isActive.value = false;
                    selectedPath.value = BannerActivationPathes.selectPath;
                    currentBanner.value = BannerModel.emptyBannerModel();
                  },
                );
              },
              child: const Text("Create"),
            ),
          ]);
    }
  }

  //create banner
  Future<void> updateBanner() async {
    if (_validation()) {
      Dialoges.showDefaultDialog(
          context: Get.context!,
          title: "update Banner",
          contant: const Text(
            'Do you want to update this Banner?',
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
                await _updateBanner().then(
                  (value) {
                    currentBannerImage.value = ImageModel.empty();
                    isActive.value = false;
                    selectedPath.value = BannerActivationPathes.selectPath;
                    currentBanner.value = BannerModel.emptyBannerModel();
                  },
                );
              },
              child: const Text("Update"),
            ),
          ]);
    }
  }

  //clear values
  void clearValues() {
    currentBannerImage.value = ImageModel.empty();
    isActive.value = false;
    selectedPath.value = BannerActivationPathes.selectPath;
    currentBanner.value = BannerModel.emptyBannerModel();
    isUpdate.value = false;
    currentBanner.refresh();
    isActive.refresh();
    selectedPath.refresh();
    isUpdate.refresh();
    currentBannerImage.refresh();
    currentBanner.refresh();
  }

  //setvalues
  void setValuesToUpdate(BannerModel banner) {
    currentBannerImage.value = ImageModel(mime: "", url: banner.imageUrl, folder: "", fileName: '');
    isActive.value = banner.isActive;
    selectedPath.value = BannerActivationPathes.values.firstWhere((element) => element.name == banner.targetScreen, orElse: () => BannerActivationPathes.selectPath);
    currentBanner.value = banner;
    isUpdate.value = true;
    currentBanner.refresh();
    currentBannerImage.refresh();
    isActive.refresh();
    selectedPath.refresh();
    isUpdate.refresh();
    currentBanner.refresh();
  }

  //validation
  bool _validation() {
    // validate currentimage

    if (currentBannerImage.value.url.isEmpty) {
      AppPopups.showWarningToast(msg: "Banner Image Is Required");

      return false;
    }

    //check image
    if (selectedPath.value == BannerActivationPathes.selectPath) {
      AppPopups.showWarningToast(msg: 'Banner Path Is Required');
      return false;
    }

    return true;
  }

  //upload banner
  Future<void> _uploadBanner() async {
    Get.back();
    currentBanner.value = BannerModel(
      id: "",
      imageUrl: currentBannerImage.value.url,
      targetScreen: selectedPath.value.name,
      isActive: isActive.value,
    );

    await bannerController.createBanner(currentBanner.value);
  }

  //update banner
  Future<void> _updateBanner() async {
    Get.back();
    currentBanner.value = BannerModel(
      id: currentBanner.value.id,
      imageUrl: currentBannerImage.value.url,
      targetScreen: selectedPath.value.name,
      isActive: isActive.value,
    );
    await bannerController.updateBanner(currentBanner.value);
  }
}
