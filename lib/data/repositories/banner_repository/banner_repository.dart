import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../models/banners/banners_model.dart';

class BannerRepository extends GetxController {
  //instanc creator
  static BannerRepository get instance => Get.find();

  //firestore instance
  final _db = FirebaseFirestore.instance;

  //fatch banners
  Future<List<BannerModel>> getBanners() async {
    try {
      final snap = await _db.collection("Banners").get();
      final list = snap.docs.map((document) => BannerModel.fromSnapshotDocument(document)).toList();
      return list;
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "Something went wrong , please try again";
    }
  }

  //remove category
  Future<void> removeBanner(String id) async {
    try {
      await _db.collection("Banners").doc(id).delete();
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "Something went wrong , please try again";
    }
  }

  //create banner
  Future<void> createBanner(BannerModel banner) async {
    try {
      //add banner
      var data = await _db.collection("Banners").add(banner.toJson());
      //update id after creating
      banner.id = data.id;
      await _db.collection("Banners").doc(data.id).update(banner.toJson());
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "Something went wrong , please try again";
    }
  }

  //update banner
  Future<void> updateBanner(BannerModel banner) async {
    try {
      //add banners
      await _db.collection("Banners").doc(banner.id).update(banner.toJson());
    } on FirebaseAuthException catch (_) {
      throw "FirebaseAuthExeption has been throwen";
    } on FirebaseException catch (_) {
      throw "FirebaseException has been throwen";
    } on FormatException catch (_) {
      throw "FormatException has been throwen";
    } on PlatformException catch (_) {
      throw "PlatformException has been throwen";
    } catch (e) {
      throw "Something went wrong , please try again====> $e";
    }
  }

  //----------------------------------------------------------------------------------------//
  //upload categories to the cloud firestore
  // Future<void> uploadDummyData(List<BannerModel> banners) async {
  //   try {
  //     final storage = Get.put(FireBaseStorageServices());
  //     for (var item in banners) {
  //       final file = await storage.getImageDataFromAssets(item.imageUrl);
  //       final url = await storage.uploadImageData("Banners", file, item.imageUrl);
  //       item.imageUrl = url;
  //       await _db.collection("Banners").doc().set(item.toJson());
  //     }
  //   } on FirebaseAuthException catch (_) {
  //     throw "FirebaseAuthExeption has been throwen";
  //   } on FirebaseException catch (_) {
  //     throw "FirebaseException has been throwen";
  //   } on FormatException catch (_) {
  //     throw "FormatException has been throwen";
  //   } on PlatformException catch (_) {
  //     throw "PlatformException has been throwen";
  //   } catch (e) {
  //     throw "Something went wrong , please try again";
  //   }
  // }
}
