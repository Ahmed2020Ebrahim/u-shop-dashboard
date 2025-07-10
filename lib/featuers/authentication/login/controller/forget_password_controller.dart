import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ushop_web/common/widgets/dialogs/dialoges.dart';
import 'package:ushop_web/data/repositories/authentication/auth_repository.dart';
import 'package:ushop_web/featuers/authentication/login/views/await_email_verification/screens/await_verification_screen.dart';
import 'package:ushop_web/utils/constants/app_images.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/app_popups.dart';

class ForgetPasswordController extends GetxController {
  // instance creator
  static ForgetPasswordController get instance => Get.find();

  //authentication repository
  final AuthRepository authRepository = Get.find();

  //variabels
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //methods
  //send password reset email
  Future<void> sendPasswordResetEmail() async {
    try {
      //check internet connectivity
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showWarningSnackBar(title: "No NetWork", message: "please check your internet connection and try again");
        return;
      }

      //form validation
      if (!forgetPasswordFormKey.currentState!.validate()) return;

      //start loading
      Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 120, height: 120));

      //send password reset email
      await authRepository.sendResetPasswordEmail(emailController.text.trim());

      //remove loading screen
      AppPopups.stopLoading();

      //show success snack bar
      AppPopups.showSuccessSnackBar(title: "sent successfully", message: "an reset password email has been sent to you , please check your inbox");

      //go to resetemailsentscreen
      Get.to(() => const AwaitVerificationScreen());
    } catch (e) {
      // stop loading spinner screen
      AppPopups.stopLoading();
      AppPopups.showErrorSnackBar(title: "oh opps", message: e.toString());
    }
  }

  //send password reset email
  void reSendPasswordResetEmail() async {
    try {
      //check internet connectivity
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showWarningSnackBar(title: "No NetWork", message: "please check your internet connection and try again");
        return;
      }

      //start loading
      Dialoges.showFullScreenDialog(child: Lottie.asset(AppImages.apploading2, width: 120, height: 120));

      //send password reset email
      await authRepository.sendResetPasswordEmail(emailController.text.trim());

      //remove loading screen
      AppPopups.stopLoading();

      //show success snack bar
      AppPopups.showSuccessSnackBar(title: "sent successfully", message: "an reset password email has been sent to you , please check your inbox");
    } catch (e) {
      // stop loading spinner screen
      AppPopups.stopLoading();
      AppPopups.showErrorSnackBar(title: "oh opps", message: e.toString());
    }
  }
}
