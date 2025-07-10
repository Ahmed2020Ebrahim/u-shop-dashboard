import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ushop_web/data/repositories/authentication/auth_repository.dart';
import '../../../../utils/popups/app_popups.dart';
import '../views/forget_password_view/widgets/verify_complated_view.dart';

class VerifyEmailController extends GetxController {
  //instance creator
  static VerifyEmailController get instance => Get.find();

  //on init method -->
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //send email verification link
  sendEmailVerification() async {
    try {
      await AuthRepository.instance.sendVerificationEmail();
      AppPopups.showSuccessSnackBar(title: "Email Sent", message: "please check your inbox");
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "Oh Opps", message: e.toString());
    }
  }

  //timer to automatically redirect on email verification
  setTimerForAutoRedirect() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => const VerifyComplatedView());
      }
    });
  }

  //manualy check if the email verified
  checkEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      Get.off(() => const VerifyComplatedView());
    } else {
      AppPopups.showWarningSnackBar(title: "Not Verified Yet !!", message: "your email is not verified , please check your inbox.");
    }
  }
}
