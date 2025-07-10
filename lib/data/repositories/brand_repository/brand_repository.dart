import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/brand/brand_model.dart';

class BrandRepository extends GetxController {
  // instance creator
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //fatch brands
  Future<List<BrandModel>> getBrands() async {
    try {
      final snap = await _db.collection("Brands").get();
      final list = snap.docs.map((document) => BrandModel.fromSnapshotDocument(document)).toList();
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

//remove brand
  Future<void> removeBrand(String id) async {
    try {
      await _db.collection("Brands").doc(id).delete();
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
  //fatch spacific brand

  //create brand
  Future<void> createBrand(BrandModel brand) async {
    try {
      //add brand
      var data = await _db.collection("Brands").add(brand.toJson());
      //update id after creating
      brand.id = data.id;
      await _db.collection("Brands").doc(data.id).update(brand.toJson());
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

  //update brand
  Future<void> updateBrand(BrandModel brand) async {
    try {
      //add brand
      await _db.collection("Brands").doc(brand.id).update(brand.toJson());
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
  Future<void> uploadDummyData(List<BrandModel> banners) async {
    try {
      // final storage = Get.put(FireBaseStorageServices());
      for (var item in banners) {
        // final file = await storage.getImageDataFromAssets(item.imageUrl);
        // final url = await storage.uploadImageData("Banners", file, item.imageUrl);
        // item.imageUrl = url;
        await _db.collection("Brands").doc(item.id).set(item.toJson());
      }
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
}
