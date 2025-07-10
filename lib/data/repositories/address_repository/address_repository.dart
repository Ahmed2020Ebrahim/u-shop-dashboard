import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/repositories/authentication/auth_repository.dart';

import '../../../utils/exceptions/firebase_exception.dart';
import '../../models/address/address_model.dart';

class AddressRepository extends GetxController {
  //instance creator
  static AddressRepository get instance => Get.find();

  //firebaseFirestore instance
  final _db = FirebaseFirestore.instance;

  final currentUserId = AuthRepository.instance.authUser!.uid;

  //fetch address
  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      if (currentUserId.isEmpty) throw "can't get the current user data . please try again later";
      final result = await _db.collection("Users").doc(AuthRepository.instance.authUser!.uid).get();
      List<dynamic> data = result['addresses'] as List<dynamic>;
      final useraddress = data.map((e) => AddressModel.fromSnapshot(e)).toList();

      return useraddress;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FormatException catch (e) {
      throw FirebaseExceptionHandler(e.message).message;
    } on PlatformException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } catch (e) {
      throw throw FirebaseExceptionHandler("some unknown happend!").message;
    }
  }

  //get selected use address by id
  Future<List<AddressModel>> getSelectedUserAdressById(String userId) async {
    try {
      final result = await _db.collection("Users").doc(userId).get();
      List<dynamic> data = result['addresses'] as List<dynamic>;
      final useraddress = data.map((e) => AddressModel.fromSnapshot(e)).toList();

      return useraddress;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FormatException catch (e) {
      throw FirebaseExceptionHandler(e.message).message;
    } on PlatformException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } catch (e) {
      throw throw FirebaseExceptionHandler("some unknown happend!").message;
    }
  }

  //select  address
  Future<void> selectNewAddress(String id) async {
    try {
      List<AddressModel> useraddress = await fetchUserAddress();

      String currentAddressId = useraddress.firstWhere((element) => element.isSelectedAddress, orElse: () => AddressModel.emptyAddressModel()).id;
      if (currentAddressId.isEmpty && useraddress.isEmpty) {
        return;
      } else {
        int index = useraddress.indexWhere((element) => element.isSelectedAddress == true);
        if (index != -1) {
          useraddress[index].isSelectedAddress = false;
        }
        index = useraddress.indexWhere((element) => element.id == id);
        useraddress[index].isSelectedAddress = true;

        await _db.collection("Users").doc(currentUserId).update({"addresses": List.generate(useraddress.length, (index) => useraddress[index].toJson())});
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FormatException catch (e) {
      throw FirebaseExceptionHandler(e.message).message;
    } on PlatformException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } catch (e) {
      throw throw FirebaseExceptionHandler("some unknown happend!").message;
    }
  }

  //add new address
  Future<void> addNewAddress(AddressModel address) async {
    try {
      List<AddressModel> useraddress = await fetchUserAddress();

      useraddress.add(address);
      await _db.collection("Users").doc(currentUserId).update({"addresses": List.generate(useraddress.length, (index) => useraddress[index].toJson())});
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FormatException catch (e) {
      throw FirebaseExceptionHandler(e.message).message;
    } on PlatformException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } catch (e) {
      throw throw FirebaseExceptionHandler("some unknown happend!").message;
    }
  }

  //delete address
  Future<void> deletAddress(String id) async {
    try {
      List<AddressModel> useraddress = await fetchUserAddress();
      useraddress.removeWhere((element) => element.id == id);
      await _db.collection("Users").doc(currentUserId).update({"addresses": List.generate(useraddress.length, (index) => useraddress[index].toJson())});
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } on FormatException catch (e) {
      throw FirebaseExceptionHandler(e.message).message;
    } on PlatformException catch (e) {
      throw FirebaseExceptionHandler(e.code).message;
    } catch (e) {
      throw throw FirebaseExceptionHandler("some unknown happend!").message;
    }
  }
}
