import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import 'package:ushop_web/utils/constants/paths.dart';
import 'package:ushop_web/utils/popups/app_popups.dart';
import '../../../common/widgets/dialogs/dialoges.dart';
import '../../../data/controllers/user/user_controller.dart';
import '../../../data/models/image/image_model.dart';
import '../../../data/models/user/user_model.dart';
import '../../../utils/constants/app_images.dart';
import '../../media/repository/media_repository.dart';

class ProfileController extends GetxController {
  //instainc creator
  static ProfileController get instance => Get.find();

  //controllers
  final UserController _userController = Get.put(UserController());
  //mediaRepository instance
  final MediaRepository _mediaRepository = Get.put(MediaRepository());
  //drop zone controller which controles images dropping in UploadImagesArea widget
  late DropzoneViewController dropzoneViewController;

  //allowed files to be uploaded
  List<String> allowedFiels = const ["image/png", "image/jpeg", "image/jpg"];

  //the images that selected by selecting button or droping
  final RxList<ImageModel> selectedImageToUpload = <ImageModel>[].obs;

  //texteditingcontrollers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  //user image
  final RxString userImage = "".obs;

  //isloading
  final RxBool isLoading = true.obs;

  //on init

  @override
  void onInit() async {
    //fetch current user data
    await _userController.fetchUserData();
    //inti every textEditingController intevalue
    firstNameController.text = _userController.currentUser.value.firstName;
    lastNameController.text = _userController.currentUser.value.lastName;
    emailController.text = _userController.currentUser.value.email;
    phoneNumberController.text = _userController.currentUser.value.phoneNumber;
    userImage.value = _userController.currentUser.value.profileImage;
    isLoading.value = false;
    super.onInit();
  }

  //update profile method
  Future<void> updateProfile() async {
    try {
      //show loading screen
      Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 120, height: 120));
      final currentUser = _userController.currentUser.value;
      final firstName = firstNameController.text.trim();
      final lastName = lastNameController.text.trim();
      final email = emailController.text.trim();
      final phoneNumber = phoneNumberController.text.trim();
      if (selectedImageToUpload.isNotEmpty) {
        userImage.value = await uploadImagesToFireStore();
      }

      final user = UserModel(
        id: currentUser.id,
        firstName: firstName.isEmpty ? currentUser.firstName : firstName,
        lastName: lastName.isEmpty ? currentUser.lastName : lastName,
        userName: currentUser.userName,
        email: email.isEmpty ? currentUser.email : email,
        phoneNumber: phoneNumber.isEmpty ? currentUser.phoneNumber : phoneNumber,
        profileImage: userImage.value.isEmpty ? currentUser.profileImage : userImage.value,
        role: currentUser.role,
      );

      await _userController.updateProfile(user);
      //close loading screen
      Get.back();

      //show success message
      AppPopups.showSuccessToast(msg: "profile updated successfully");
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    }
  }

  //select local images
  Future<void> selectProfileImage() async {
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

  Future<String> uploadImagesToFireStore() async {
    try {
      var selectedImage = selectedImageToUpload.first;
      final image = selectedImage.localImageToUpdate;
      //upload Image to firebase storage
      final ImageModel uploadedImage = await _mediaRepository.uploadImagesToFirebaseStorage(
        fileBytes: image!,
        path: AppPaths.usersPath,
        fileName: selectedImage.fileName,
        mime: selectedImage.mime,
      );
      uploadedImage.mediaCategory = MediaDropdownSectons.users.name;
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

  // Future<void> selectProfileImage() async {
  //   final files = await dropzoneViewController.pickFiles(mime: allowedFiels, multiple: true);
  //   for (var file in files) {
  //     if (allowedFiels.contains(file.type)) {
  //       final byte = await dropzoneViewController.getFileData(file);
  //       final image = ImageModel(mime: file.type, url: "", folder: "", fileName: file.name, localImageToUpdate: Uint8List.fromList(byte), file: file);
  //       selectedImageToUpload.add(image);
  //       selectedImageToUpload;
  //       selectedImageToUpload.refresh();
  //     }
  //   }
  // }
}
