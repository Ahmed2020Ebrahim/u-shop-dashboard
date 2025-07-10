import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ushop_web/common/widgets/buttons/app_primary_button.dart';
import 'package:ushop_web/common/widgets/dialogs/dialoges.dart';
import 'package:ushop_web/common/widgets/layouts/sidebar/controllers/app_navigation_controller.dart';
import 'package:ushop_web/data/controllers/user/user_controller.dart';
import 'package:ushop_web/data/repositories/authentication/auth_repository.dart';
import 'package:ushop_web/utils/constants/app_images.dart';
import 'package:ushop_web/utils/constants/colors.dart';
import 'package:ushop_web/utils/constants/texts.dart';
import 'package:ushop_web/utils/popups/full_screen_loader.dart';

import '../../../../data/models/user/user_model.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/app_popups.dart';
import '../../../routes/app_routs.dart';
import '../../repositories/user/user_repository.dart';

class AuthController extends GetxController {
  //create instance
  static AuthController get instance => Get.find();

  //variabels
  final Rx<TextEditingController> email = TextEditingController().obs;
  final Rx<TextEditingController> password = TextEditingController().obs;
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  final localStorage = GetStorage();
  final Rx<bool> hidePassword = true.obs;
  Rx<bool> rememberMe = false.obs;

  //user controller
  final UserController _userController = Get.put(UserController());

  //!---> oninit -------

  @override
  void onInit() {
    email.value.text = localStorage.read(AppTexts.rememberMeEmail) ?? "";
    password.value.text = localStorage.read(AppTexts.rememberMePassword) ?? "";
    super.onInit();
  }

  //!--->    //---METHODS----//

  //sign up
  Future<void> logIn() async {
    try {
      //check internet connectivity
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showWarningSnackBar(title: "No NetWork", message: "please check your internet connection and try again");
        return;
      }

      //form validation
      if (!signUpFormKey.currentState!.validate()) return;

      //start loading
      FullScreenLoader.open("processing data....", AppImages.apploading2);

      //remember me check
      if (rememberMe.value) {
        localStorage.write(AppTexts.rememberMeEmail, email.value.text.trim());
        localStorage.write(AppTexts.rememberMePassword, password.value.text);
      }

      //regester user in firebase authentication & save user data in the firebase
      await AuthRepository.instance.loginWithEmailAndPassword(email.value.text.trim(), password.value.text);

      //fetch user data
      final user = await _userController.fetchUserData();

      //start session
      await AuthRepository.instance.setAuthPresistence();

      //stop loading screen
      FullScreenLoader.close();

      //check user role
      if (user.role != "admin") {
        await AuthRepository.instance.logOut();
        AppPopups.showErrorSnackBar(title: "not authorized", message: "this user is not or has no access");
      } else {
        AuthRepository.instance.redirectScreen();
      }

      //show success message
      AppPopups.showSuccessSnackBar(title: "successfully done", message: "you have successfully signed up");

      // go  dashboard or login
      AuthRepository.instance.redirectScreen();
    } catch (e) {
      FullScreenLoader.close();
      // show generic error for the user
      AppPopups.showErrorSnackBar(title: "Oppss Error", message: e.toString());
    }
  }

  //admin register
  Future<void> registreAdmin() async {
    try {
      //check internet connectivity
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showWarningSnackBar(title: "No NetWork", message: "please check your internet connection and try again");
        return;
      }

      // //form validation
      // if (!signUpFormKey.currentState!.validate()) return;

      //start loading
      FullScreenLoader.open("processing your data ....", AppImages.apploading2);

      //regester user in firebase authentication & save user data in the firebase
      final userCredential = await AuthRepository.instance.registerWithEmailAndPassword(AppTexts.adminEmail, AppTexts.adminPassword);
      final user = UserModel(
        id: userCredential.user!.uid,
        firstName: "Ushop",
        lastName: "admin",
        userName: "UshopAdmin",
        email: AppTexts.adminEmail,
        phoneNumber: "",
        profileImage: "",
        role: "admin",
      );

      //save authenticated user data in firebase firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(user);

      //stop loading screen
      FullScreenLoader.close();

      //show success message
      AppPopups.showSuccessSnackBar(title: "successfully done", message: "you have successfully signed up");

      // go to email verify screen
      AuthRepository.instance.redirectScreen();

      //
    } catch (e) {
      FullScreenLoader.close();
      // show generic error for the user
      AppPopups.showErrorSnackBar(title: "Oppss Error", message: e.toString());
    }
  }

  Future<void> logOut() async {
    AppNavigationController.instance.appNavigate(AppRouts.dashboard);
    //show dialog
    Dialoges.showDefaultDialog(context: Get.context!, title: 'Log out?', contant: const Text("Do you want to log out?"), actions: [
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text("Cancel"),
      ),
      SizedBox(
        height: 40,
        width: 100,
        child: AppPrimaryButton(
          color: AppColors.error,
          labelColor: AppColors.white,
          label: 'Log Out',
          onTap: () async {
            Get.back();
            await _logOutApp();
            Get.offAllNamed(AppRouts.logout);
          },
        ),
      ),
    ]);
  }

  Future<void> _logOutApp() async {
    try {
      //check internet connectivity
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showWarningSnackBar(title: "No NetWork", message: "please check your internet connection and try again");
        return;
      }

      //start loading
      FullScreenLoader.open("logining out ....", AppImages.apploading1);

      //loging out
      await AuthRepository.instance.logOut();

      //stop loading screen
      FullScreenLoader.close();

      //show success message
      AppPopups.showSuccessSnackBar(title: "Loged Out", message: "you have Loged out");
    } catch (e) {
      FullScreenLoader.close();
      // show generic error for the user
      AppPopups.showErrorSnackBar(title: "Oppss Error", message: e.toString());
    }
  }
}
