import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ushop_web/featuers/settings/models/settings_model.dart';

class SettingsRepository extends GetxController {
  //instance
  static SettingsRepository get instance => Get.find();

  //data base instance
  final _db = FirebaseFirestore.instance;

  //fetch App Settings
  Future<SettingsModel> fetchAppSettings() async {
    try {
      final snapShot = await _db.collection("Settings").doc("app_settings").get();
      final data = SettingsModel.fromSnapshot(snapShot);
      return data;
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

  //update app settings
  Future<void> updateAppSettings(SettingsModel settingsModel) async {
    try {
      await _db.collection("Settings").doc("app_settings").update(settingsModel.toJson());
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

  // //set app settings for the first time
  // Future<void> setAppSettings(SettingsModel settingsModel) async {
  //   try {
  //     await _db.collection("Settings").doc("app_settings").set(settingsModel.toJson());
  //   } on FirebaseAuthException catch (_) {
  //     throw "FirebaseAuthExeption has been throwen";
  //   } on FirebaseException catch (_) {
  //     throw "FirebaseException has been throwen";
  //   } on FormatException catch (_) {
  //     throw "FormatException has been throwen";
  //   } on PlatformException catch (_) {
  //     throw "PlatformException has been throwen";
  //   } catch (e) {
  //     throw "some thing went wrong";
  //   }
  // }
}
