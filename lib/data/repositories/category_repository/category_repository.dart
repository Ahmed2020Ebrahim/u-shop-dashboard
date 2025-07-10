import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/category/category_model.dart';

class CategoryRepository extends GetxController {
  // instanc creator
  static CategoryRepository get instance => Get.find();

  //firestor instance
  final _db = FirebaseFirestore.instance;

  //get all categories method
  Future<List<CategoryModel>> getCategories() async {
    try {
      final snap = await _db.collection("Categories").get();

      final list = snap.docs.map((document) => CategoryModel.fromSnapshotDocument(document)).toList();

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
  Future<void> removeCategory(String id) async {
    try {
      await _db.collection("Categories").doc(id).delete();
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

  //create category
  Future<void> createCategory(CategoryModel category) async {
    try {
      //add category
      var data = await _db.collection("Categories").add(category.toJson());
      //update id after creating
      category.id = data.id;
      await _db.collection("Categories").doc(data.id).update(category.toJson());
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

  //update category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      //add category
      await _db.collection("Categories").doc(category.id).update(category.toJson());
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

  //get sub categories method

  //upload categories to the cloud firestore
  // Future<void> uploadDummyData(List<CategoryModel> categories) async {
  //   try {
  //     final storage = Get.put(FireBaseStorageServices());
  //     for (var category in categories) {
  //       final file = await storage.getImageDataFromAssets(category.image);
  //       final url = await storage.uploadImageData("Categories", file, category.name);
  //       category.image = url;
  //       await _db.collection("Categories").doc(category.id).set(category.toJson());
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
