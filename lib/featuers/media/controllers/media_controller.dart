import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:ushop_web/common/widgets/dialogs/dialoges.dart';
import 'package:ushop_web/data/models/image/image_model.dart';
import 'package:ushop_web/featuers/media/repository/media_repository.dart';
import 'package:ushop_web/utils/constants/enums.dart';
import 'package:ushop_web/utils/constants/paths.dart';
import 'package:ushop_web/utils/popups/app_popups.dart';
import '../../../common/widgets/bottom_sheets/show_select_images_bottomsheet.dart';
import '../widgets/dialogs/delete_media_dialog.dart';
import '../widgets/dialogs/image_detels_dialog.dart';
import '../widgets/dialogs/upload_image_confirmation_dialog.dart';
import '../widgets/dialogs/uploading_media_fullscreen_dialog.dart';

class MediaController extends GetxController {
  //instance creator
  static MediaController get instance => Get.find();

  //mediaRepository instance
  final MediaRepository _mediaRepository = Get.put(MediaRepository());

  //media lists(bannars , brands , categories , products , users)
  // final RxList<ImageModel> _bannersList = <ImageModel>[].obs;
  // final RxList<ImageModel> _brandsList = <ImageModel>[].obs;
  // final RxList<ImageModel> _categoriessList = <ImageModel>[].obs;
  // final RxList<ImageModel> _productsList = <ImageModel>[].obs;
  // final RxList<ImageModel> _usersList = <ImageModel>[].obs;

  //drop zone controller which controles images dropping in UploadImagesArea widget
  late DropzoneViewController dropzoneViewController;

  //currnt folder list which contains List of Images of the currentFolder selection
  final RxList<ImageModel> currentFolderList = <ImageModel>[].obs;

  //currnt folder which is the state of the current dropdown selection
  final Rx<MediaDropdownSectons> currentFolder = MediaDropdownSectons.folders.obs;

  //the images that selected by selecting button or droping
  final RxList<ImageModel> selectedImageToUpload = <ImageModel>[].obs;

  //isloading
  final RxBool isLoading = false.obs;

  //isDragZoneShowen to controlle the hide and showing of the dropzone area
  final RxBool isDragZoneShowen = false.obs;

  //allowed files to be uploaded
  List<String> allowedFiels = const ["image/png", "image/jpeg", "image/jpg"];

  //isdeleting
  final RxBool isDeleting = false.obs;

  //selection states variabels
  final RxBool isSelectable = false.obs;
  final RxBool isMultiSelectable = false.obs;

  //current selected images
  final RxList<ImageModel> currentSelectedImages = <ImageModel>[].obs;

  //upload images confirmation
  void showUploadImagesConfirmationDialog() {
    if (currentFolder.value == MediaDropdownSectons.folders) {
      AppPopups.showWarningSnackBar(title: "Select Folder", message: "You have to select a folder before uploading the images");
      return;
    }
    uploadImageConfirmationDialog(onConfirm: () async {
      Get.back();
      await uploadImagesToFireStore();
    });
  }

  //upload images to FireStore
  Future<void> uploadImagesToFireStore() async {
    try {
      //show loading screen
      _showUpLoadingScreen();
      //loop for uploading files
      for (var i = selectedImageToUpload.length - 1; i >= 0; i--) {
        var selectedImage = selectedImageToUpload[i];
        final image = selectedImage.localImageToUpdate;
        //upload Image to firebase storage
        final ImageModel uploadedImage = await _mediaRepository.uploadImagesToFirebaseStorage(
          fileBytes: image!,
          path: _getPath(),
          fileName: selectedImage.fileName,
          mime: selectedImage.mime,
        );
        uploadedImage.mediaCategory = currentFolder.value.name;
        //upload image to firebase database
        final id = await _mediaRepository.uploadImagesToFirebaseDatabase(uploadedImage);
        uploadedImage.id = id;
        selectedImageToUpload.removeAt(i);
        // currentFolderList.add({"imageUrl": uploadedImage.url, "id": uploadedImage.id});
        currentFolderList.add(uploadedImage);
        currentFolder.refresh();

        //stop loadin
      }
      Get.back();
      AppPopups.showSuccessToast(msg: "SuccesFully Added");
    } catch (e) {
      //hide current dialog
      Dialoges.hideCurrentDialog();
      //show error snak
      AppPopups.showErrorSnackBar(title: "Error", message: e.toString());
    }
  }

  //change dragezone showing state
  void changeDrageZoneState() {
    isDragZoneShowen.value = !isDragZoneShowen.value;
  }

  //select local images
  Future<void> selectLocalImages() async {
    final files = await dropzoneViewController.pickFiles(mime: allowedFiels, multiple: true);
    for (var file in files) {
      if (allowedFiels.contains(file.type)) {
        final byte = await dropzoneViewController.getFileData(file);
        final image = ImageModel(mime: file.type, url: "", folder: "", fileName: file.name, localImageToUpdate: Uint8List.fromList(byte), file: file);
        selectedImageToUpload.add(image);
        selectedImageToUpload;
        selectedImageToUpload.refresh();
      }
    }
  }

  //on remove all
  void onRemoveAll() {
    selectedImageToUpload.clear();
  }

  //showImageDetailsDialog
  void showImageDetailsDialog(ImageModel image, BuildContext context) {
    imageDetailsDialgo(context, image);
  }

  //delet image
  Future<void> deletImage(ImageModel image) async {
    try {
      deleteMediaDialog(
          deletedImage: image,
          onRemove: () async {
            isDeleting.value = true;
            Get.back();
            await _mediaRepository.deletImage(id: image.id, fullPath: image.fullPath!);
            Get.back();
            currentFolderList.removeWhere((element) => element.id == image.id);
            isDeleting.value = false;
            currentFolder.refresh();
            AppPopups.showSuccessToast(msg: "SuccesFully Deleted");
          });
    } catch (e) {
      isDeleting.value = false;
      Get.back();
      AppPopups.showErrorSnackBar(title: "Error", message: e.toString());
    }
  }

  //on folder change
  //fetch images from database
  Future<void> fetchImagesFromDatabase(MediaDropdownSectons folder) async {
    try {
      isLoading.value = true;
      currentFolder.value = folder;
      if (folder == MediaDropdownSectons.folders) {
        currentFolder.value = MediaDropdownSectons.folders;
        currentFolderList.value = [];
        isLoading.value = false;
        return;
      }

      final data = await _mediaRepository.fetchImagesFromDatabase(mediaCategory: currentFolder.value, loadCount: 10);
      if (data.isEmpty) {
        AppPopups.showWarningToast(msg: "There is no ${currentFolder.value.name.toString()}");
        currentFolderList.value = [];
        isLoading.value = false;
        return;
      }

      currentFolderList.clear();
      currentFolderList.assignAll(data);
      currentFolderList.refresh();

      if (isSelectable.value) {
        if (isMultiSelectable.value) {
          //set all isSelected to false
          for (var element in currentFolderList) {
            element.isSelected.value = false;
          }
          for (var element in currentSelectedImages) {
            for (var i = 0; i < currentFolderList.length; i++) {
              if (element.id == currentFolderList[i].id) {
                currentFolderList[i].isSelected.value = true;
              }
            }
          }
          currentFolderList.refresh();
        } else {
          //set all isSelected to false
          for (var element in currentFolderList) {
            element.isSelected.value = false;
          }
          for (var element in currentSelectedImages) {
            for (var i = 0; i < currentFolderList.length; i++) {
              if (element.id == currentFolderList[i].id) {
                currentFolderList[i].isSelected.value = true;
              }
            }
          }
        }
      }
      isLoading.value = false;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "Error", message: "error: $e");
    }
  }

  //load moare images
  Future<void> loadMoreImages(MediaDropdownSectons folder) async {
    try {
      currentFolder.value = folder;
      if (folder == MediaDropdownSectons.folders) {
        currentFolder.value = MediaDropdownSectons.folders;
        currentFolderList.value = [];
        return;
      } else if (folder == MediaDropdownSectons.bannars) {
        currentFolder.value = folder;
      } else if (folder == MediaDropdownSectons.brands) {
        currentFolder.value = folder;
      } else if (folder == MediaDropdownSectons.categories) {
        currentFolder.value = folder;
      } else if (folder == MediaDropdownSectons.products) {
        currentFolder.value = folder;
      } else if (folder == MediaDropdownSectons.users) {
        currentFolder.value = folder;
      }
      final data = await _mediaRepository.loadMoreImagesFromDatabase(
        mediaCategory: currentFolder.value,
        loadCount: 10,
        lastFetchedData: currentFolderList.last.createdAt ?? DateTime.now(),
      );
      if (data.isEmpty) {
        AppPopups.showWarningToast(msg: "There is no other ${currentFolder.value.name.toString()}");
      }
      currentFolderList.addAll(data);
      currentFolderList.refresh();
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "Error", message: "error: $e");
    }
  }

  //show select productImage
  Future<List<ImageModel>?> showSelectProductImagesBottomSheet({
    bool selectable = false,
    bool multiSelectable = false,
    List<ImageModel>? selectedImages,
    MediaDropdownSectons? folder,
  }) async {
    isSelectable.value = selectable;
    isMultiSelectable.value = multiSelectable;
    currentSelectedImages.value = selectedImages ?? [];
    currentFolder.value = folder ?? MediaDropdownSectons.folders;
    await fetchImagesFromDatabase(folder ?? MediaDropdownSectons.folders);

    currentSelectedImages.refresh();
    return await showSelectImagesBottomSheet();
  }

  void backWithSelectedImages() {
    Get.back(result: currentSelectedImages);
  }

  //on select media change
  void onSelectedChange(String imageId) {
    final int index = currentFolderList.indexWhere((element) => element.id == imageId);
    if (isMultiSelectable.value) {
      final String currentId = currentFolderList[index].id;
      bool result = currentSelectedImages.any((element) => element.id == currentId);
      // currentFolderList[index].isSelected.value = !currentFolderList[index].isSelected.value;
      //the list is emtpy
      if (currentSelectedImages.isEmpty) {
        currentSelectedImages.add(currentFolderList[index]);
        currentFolderList[index].isSelected.value = true;
        currentFolderList.refresh();
      } else {
        //if value change to false
        if (result) {
          currentFolderList[index].isSelected.value = false;
          currentSelectedImages.removeWhere((element) => element.id == currentId);
          currentSelectedImages.refresh();
        } else {
          currentFolderList[index].isSelected.value = true;
          currentFolderList.refresh();
          final ImageModel selected = currentFolderList[index];
          selected.isSelected.value = true;
          currentSelectedImages.add(selected);
          currentSelectedImages.refresh();
        }
      }
    } else {
      final bool currentValue = currentFolderList[index].isSelected.value;
      for (var image in currentFolderList) {
        image.isSelected.value = false;
      }

      if (currentValue == true) {
        currentFolderList[index].isSelected.value = false;
        currentSelectedImages.clear();
      } else {
        currentFolderList[index].isSelected.value = true;
        currentSelectedImages.clear();
        currentSelectedImages.add(currentFolderList[index]);
        currentSelectedImages.refresh();
      }
    }
    currentFolderList.refresh();
  }

  //reset values
  void resetValues(bool canSelect) {
    isSelectable.value = canSelect;
    currentFolder.value = MediaDropdownSectons.folders;
    currentFolderList.value = [];
    currentSelectedImages.value = [];
  }

  //show loading screen unt uploading
  Future<dynamic> _showUpLoadingScreen() {
    final controller = Get.put(MediaController());
    return upladingMediaFullScreenDialog(controller);
  }

  //get folder path
  String _getPath() {
    String path = "";
    switch (currentFolder.value) {
      case MediaDropdownSectons.bannars:
        path = AppPaths.bannarsPath;
        break;
      case MediaDropdownSectons.brands:
        path = AppPaths.brandsPath;
        break;
      case MediaDropdownSectons.categories:
        path = AppPaths.categoriesPath;
        break;
      case MediaDropdownSectons.products:
        path = AppPaths.productsPath;
        break;
      case MediaDropdownSectons.users:
        path = AppPaths.usersPath;
        break;
      default:
        break;
    }
    return path;
  }

  //set media data
}
