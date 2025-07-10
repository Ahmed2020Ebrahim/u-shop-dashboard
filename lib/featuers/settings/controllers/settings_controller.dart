import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/common/widgets/dialogs/dialoges.dart';
import 'package:ushop_web/utils/constants/app_images.dart';

import '../../../data/models/image/image_model.dart';
import '../../../utils/constants/paths.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/app_popups.dart';
import '../../media/repository/media_repository.dart';
import '../models/settings_model.dart';
import '../repositories/settings_repository.dart';

class SettingsController extends GetxController {
  //instance
  static SettingsController get instance => Get.find();

  //settings repository
  final SettingsRepository _settingsRepository = Get.put(SettingsRepository());

  //media controller
  final MediaRepository _mediaRepository = Get.put(MediaRepository());

  //app settings
  final Rx<SettingsModel> appSettings = SettingsModel.empty().obs;

  //keyform
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  //controllers
  final TextEditingController appNamerController = TextEditingController();
  final TextEditingController supportEmailController = TextEditingController();
  final TextEditingController taxRateController = TextEditingController();
  final TextEditingController shippingCostController = TextEditingController();
  final TextEditingController freeShippingThresholdController = TextEditingController();

  //AppImage
  final RxString appImage = "".obs;

  //drop zone controller which controles images dropping in UploadImagesArea widget
  late DropzoneViewController dropzoneViewController;

  //allowed files to be uploaded
  List<String> allowedFiels = const ["image/png", "image/jpeg", "image/jpg"];

  //the images that selected by selecting button or droping
  final RxList<ImageModel> selectedImageToUpload = <ImageModel>[].obs;

  //isLoading
  final RxBool isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await fetchAppSettings();
    super.onInit();
  }

  //select local images
  Future<void> selectAppImage() async {
    // Pick a single file only
    final files = await dropzoneViewController.pickFiles(
      mime: allowedFiels,
      multiple: false,
    );

    if (files.isNotEmpty) {
      final file = files.first;

      if (allowedFiels.contains(file.type)) {
        final byte = await dropzoneViewController.getFileData(file);

        final image = ImageModel(
          mime: file.type,
          url: "",
          folder: "",
          fileName: file.name,
          localImageToUpdate: Uint8List.fromList(byte),
          file: file,
        );

        // Clear any previously selected image (optional)
        selectedImageToUpload.clear();

        // Add new image
        selectedImageToUpload.add(image);
        selectedImageToUpload.refresh();
      } else {
        // Optional: handle unsupported file type
        AppPopups.showErrorToast(msg: "Unsupported file type: ${file.type}");
      }
    }
  }

  //fetch app settings
  Future<void> fetchAppSettings() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }
      //start loading
      isLoading.value = true;

      //fatch data
      appSettings.value = await _settingsRepository.fetchAppSettings();
      appImage.value = appSettings.value.appImageUrl;
      appNamerController.text = appSettings.value.appName;
      taxRateController.text = appSettings.value.taxRate.toString();
      shippingCostController.text = appSettings.value.shippingCost.toString();
      freeShippingThresholdController.text = appSettings.value.freeShippingThreshold.toString();
      supportEmailController.text = appSettings.value.supportedEmail;
      selectedImageToUpload.clear();

      //stop loading
      isLoading.value = false;
    } catch (e) {
      //show error message
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loading
      isLoading.value = false;
    }
  }

  //update app settings
  Future<void> updateAppSettings() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return;
      }
      //validat
      if (!_validate()) {
        return;
      }

      //start loading
      Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 120, height: 120, animate: true));

      //upload imge to firestorage
      if (selectedImageToUpload.isNotEmpty) {
        appImage.value = await _uploadImagesToFireStore();
      }
      // print all values

      appSettings.value = SettingsModel(
        appImageUrl: appImage.value,
        appName: appNamerController.text,
        taxRate: double.parse(taxRateController.text),
        shippingCost: double.parse(shippingCostController.text),
        freeShippingThreshold: double.parse(shippingCostController.text),
        supportedEmail: supportEmailController.text,
      );

      //update data
      await _settingsRepository.updateAppSettings(appSettings.value);

      //stop loading
      Dialoges.hideCurrentDialog();
      AppPopups.showSuccessToast(msg: "Settings Updated Successfully");
    } catch (e) {
      //show error message
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      //stop loading
      isLoading.value = false;
    }
  }

  // //set app settings
  // Future<void> setAppSettings() async {
  //   try {
  //     //check internet connection
  //     final isConnected = await NetworkManager.instance.isNetworkConnection();
  //     if (!isConnected) {
  //       AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
  //       return;
  //     }

  //     Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 120, height: 120, animate: true));

  //     //validat
  //     if (!_validate()) {
  //       return;
  //     }

  //     //upload image to firestorage
  //     appImage.value = await _uploadImagesToFireStore();

  //     appSettings.value = SettingsModel(
  //       appImageUrl: appImage.value,
  //       appName: appNamerController.text,
  //       taxRate: double.parse(taxRateController.text),
  //       shippingCost: double.parse(shippingCostController.text),
  //       freeShippingThreshold: double.parse(shippingCostController.text),
  //     );

  //     //start loading

  //     //update data
  //     await _settingsRepository.setAppSettings(appSettings.value);

  //     //stop loading
  //     Dialoges.hideCurrentDialog();
  //     AppPopups.showSuccessToast(msg: "Done");
  //   } catch (e) {
  //     //show error message
  //     AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
  //   } finally {
  //     //stop loading
  //     isLoading.value = false;
  //   }
  // }

  //upload image to firebase storage and firebase database
  Future<String> _uploadImagesToFireStore() async {
    try {
      var selectedImage = selectedImageToUpload.first;
      final image = selectedImage.localImageToUpdate;
      //upload Image to firebase storage
      final ImageModel uploadedImage = await _mediaRepository.uploadImagesToFirebaseStorage(
        fileBytes: image!,
        path: AppPaths.appLogo,
        fileName: selectedImage.fileName,
        mime: selectedImage.mime,
      );
      uploadedImage.mediaCategory = "appLogo";
      //upload image to firebase database
      final id = await _mediaRepository.uploadImagesToFirebaseDatabase(uploadedImage);
      uploadedImage.id = id;
      selectedImageToUpload.clear();

      return uploadedImage.url;
    } catch (e) {
      //show error snak

      AppPopups.showErrorSnackBar(title: "Error", message: e.toString());
      return "";
    }
  }

  //validat
  bool _validate() {
    if (!keyForm.currentState!.validate()) {
      AppPopups.showWarningToast(msg: "Check Required Fields");
      return false;
    }
    if (selectedImageToUpload.isEmpty && appImage.value.isEmpty) {
      AppPopups.showWarningToast(msg: "Pleas Select App Image");
      return false;
    }
    return true;
  }
}
