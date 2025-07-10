import 'package:get/get.dart';
import 'package:ushop_web/data/models/user/user_model.dart';
import 'package:ushop_web/data/repositories/authentication/auth_repository.dart';

import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/app_popups.dart';
import '../../repositories/user/user_repository.dart';

class UserController extends GetxController {
  //instance creator
  static UserController get instance => Get.find();

  //user data
  final Rx<UserModel> currentUser = UserModel.empty().obs;

  //all users
  final RxList<UserModel> allUsers = <UserModel>[].obs;

  //is loading
  final RxBool isLoading = false.obs;

  @override
  void onInit() async {
    if (AuthRepository.instance.isAuthenticated) {
      currentUser.value = await fetchUserData();
      await fetchAllUsers();
    }
    super.onInit();
  }

  //user repository
  final UserRepository _userRepository = UserRepository();

  //updateProfile
  Future<bool> updateProfile(UserModel user) async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return false;
      }

      //update user data
      await _userRepository.updateUserData(user);
      currentUser.value = user;
      currentUser.refresh();

      return true;
    } catch (e) {
      //show error message
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
      return false;
    }
  }

  //fetch user data
  Future<UserModel> fetchUserData() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
        return UserModel.empty();
      }
      //start loading
      isLoading.value = true;

      //fatch user data
      currentUser.value = await _userRepository.fatchUserData().then(
        (value) {
          return value;
        },
      );

      //return data
      return currentUser.value;
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
      return UserModel.empty();
    } finally {
      isLoading.value = false;
    }
  }

  //fetch all users
  Future<void> fetchAllUsers() async {
    try {
      //check internet connection
      final isConnected = await NetworkManager.instance.isNetworkConnection();
      if (!isConnected) {
        AppPopups.showErrorSnackBar(title: "NO INTERNET CONNECTION", message: "please check your internet connection and try again");
      }
      //start loading
      isLoading.value = true;

      //fatch user data
      allUsers.value = await _userRepository.fetchAllUsers();
    } catch (e) {
      AppPopups.showErrorSnackBar(title: "oh oops", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String? getUserImage(String userId) {
    final user = allUsers.firstWhere((element) => element.id == userId, orElse: () => UserModel.empty());
    return user.profileImage.isEmpty ? null : user.profileImage;
  }

  //reorder users according to user desire
  Future<void> reOrderUsers(String orderby, bool ascending) async {
    switch (orderby) {
      case "name":
        ascending ? allUsers.sort((a, b) => a.userName.compareTo(b.userName)) : allUsers.sort((a, b) => b.userName.compareTo(a.userName));
        break;

      default:
        {
          ascending
              ? allUsers.sort((a, b) => a.userName.compareTo(b.userName))
              : allUsers.sort(
                  (a, b) => b.userName.compareTo(a.userName),
                );

          allUsers.refresh();
          break;
        }
    }
  }
}
