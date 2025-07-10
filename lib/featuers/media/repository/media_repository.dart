import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/models/image/image_model.dart';

import '../../../utils/constants/enums.dart';

class MediaRepository extends GetxController {
  //instance creator
  static MediaRepository get instance => Get.find();

  //firebase storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //upload images to firebase storage
  Future<ImageModel> uploadImagesToFirebaseStorage({required String path, required Uint8List fileBytes, required String fileName, required String mime}) async {
    try {
      final Reference ref = _storage.ref("$path/$fileName");
      final sTmetadata = SettableMetadata(contentType: mime);

      final uploadTask = await ref.putData(fileBytes, sTmetadata);
      final String downloadUrl = await uploadTask.ref.getDownloadURL();
      final FullMetadata metaData = await uploadTask.ref.getMetadata();
      return ImageModel.fromFirebaseMetaData(metaData, path, fileName, downloadUrl, mime);
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

  //upload images to firebase database
  Future<String> uploadImagesToFirebaseDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance.collection("Images").add(image.toJson());
      return data.id;
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

  //fetch images from database
  Future<List<ImageModel>> fetchImagesFromDatabase({required MediaDropdownSectons mediaCategory, required int loadCount}) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection("Images")
          .where(
            "mediaCategory",
            isEqualTo: mediaCategory.name.toString(),
          )
          .orderBy("createdAt", descending: false)
          .limit(loadCount)
          .get();

      return data.docs.map((e) => ImageModel.fromSnapShot(e)).toList();
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

  //load more images from database
  Future<List<ImageModel>> loadMoreImagesFromDatabase({required MediaDropdownSectons mediaCategory, required int loadCount, required DateTime lastFetchedData}) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection("Images")
          .where(
            "mediaCategory",
            isEqualTo: mediaCategory.name.toString(),
          )
          .orderBy("createdAt", descending: false)
          .startAfter([lastFetchedData])
          .limit(loadCount)
          .get();

      return data.docs.map((e) => ImageModel.fromSnapShot(e)).toList();
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }

  //delet Image
  //load more images from database
  Future<void> deletImage({required String id, required String fullPath}) async {
    try {
      // Delete from Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child(fullPath);
      await storageRef.delete();

      //  Delete from Firestore
      await FirebaseFirestore.instance.collection("Images").doc(id).delete();
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "some thing went wrong";
    }
  }
}
