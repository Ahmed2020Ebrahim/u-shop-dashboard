import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ushop_web/routes/app_routs.dart';
import 'package:ushop_web/utils/exceptions/firebase_exception.dart';
import 'package:ushop_web/utils/logging/app_logger.dart';

class AuthRepository extends GetxController {
  //instance creator
  static AuthRepository get instance => Get.find();

  //firebase instance
  final _auth = FirebaseAuth.instance;

  //variabels
  final deviceStorage = GetStorage();

  //is user authenticated
  bool get isAuthenticated => _auth.currentUser != null;

  //get current authenticated user data
  User? get authUser => _auth.currentUser;

  //on ready
  @override
  void onReady() async {
    await setAuthPresistence();
    super.onReady();
  }

  //set presistence
  Future<void> setAuthPresistence() async {
    await _auth.setPersistence(Persistence.LOCAL);
  }

  //redirect screen
  void redirectScreen() async {
    final user = _auth.currentUser;
    if (user != null) {
      Get.offAllNamed(AppRouts.dashboard);
    } else {
      Get.offAndToNamed(AppRouts.login);
    }
  }

  //!------------------------ Email & password Auth -------------------//

  // [EmailAuthentication]   -   register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
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

  // [EmailAuthentication]   -   sign in
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
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

  /// [EMAIL VERIFICATION]   -   email verification
  Future<void> sendVerificationEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
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

  // [REAUTHENTICATE USER]   -   reauthenticate user
  Future<void> reauthenticateWithEmailPassword(String email, String password) async {
    try {
      // Create EmailAuthCredential
      final credential = EmailAuthProvider.credential(email: email, password: password);

      // Reauthenticate the user with email and password
      await _auth.currentUser!.reauthenticateWithCredential(credential);
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

  // [  FORGET PASSWORD  ]   -   forget password
  Future<void> sendResetPasswordEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      AppLogger.warning("email sent successfully to $email");
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

  // [USER LOGOUT]  - logout
  Future<void> logOut() async {
    try {
      await _auth.signOut();
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
