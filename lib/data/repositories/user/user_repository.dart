import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ushop_web/data/repositories/authentication/auth_repository.dart';

import '../../models/user/user_model.dart';

class UserRepository extends GetxController {
  // instance creator
  static UserRepository get instance => Get.find();

  //firebase firestore instance
  final _db = FirebaseFirestore.instance;

  // save user record on firebase firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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

  //check if the user is exist before save new recored
  Future<bool> isUidExists(String uid) async {
    try {
      // Reference to the Firestore collection
      CollectionReference users = FirebaseFirestore.instance.collection('Users');

      // Query to check if the UID exists in any document
      QuerySnapshot snapshot = await users.where('id', isEqualTo: uid).get();

      // If any documents are found with the given UID, return true
      return snapshot.docs.isNotEmpty;
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

  //save user record after social login
  Future<void> saveSocialUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final isUidExist = await isUidExists(userCredential.user!.uid);
        if (isUidExist) {
          return;
        } else {
          final nameParts = UserModel.nameParts(userCredential.user!.displayName ?? "");
          final userName = UserModel.generatUserName(userCredential.user!.displayName ?? "");
          final user = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts[1].length > 1 ? nameParts.sublist(1).join(" ") : "",
            userName: userName,
            email: userCredential.user!.email ?? "",
            phoneNumber: userCredential.user!.phoneNumber ?? "",
            profileImage: userCredential.user!.photoURL ?? "",
            role: "user",
          );
          await saveUserRecord(user);
        }
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

  //fatch user data
  Future<UserModel> fatchUserData() async {
    try {
      final documentSnapshot = await _db.collection("Users").doc(AuthRepository.instance.authUser!.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
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

  //update user data
  Future<void> updateUserData(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).update(user.toJson());
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

  //update user spacific field
  Future<void> updateUserSpaciceFields(Map<String, dynamic> json) async {
    try {
      await _db.collection("Users").doc(AuthRepository.instance.authUser!.uid).update(json);
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

  //remove user data
  Future<void> removeUserData(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
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

  //upload image
  Future<String> uploadUserImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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

  //fetch all users data
  Future<List<UserModel>> fetchAllUsers() async {
    try {
      final documentSnapshot = await _db.collection("Users").where("role", isEqualTo: "user").get();
      return documentSnapshot.docs.map((user) => UserModel.fromSnapshot(user)).toList();
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
