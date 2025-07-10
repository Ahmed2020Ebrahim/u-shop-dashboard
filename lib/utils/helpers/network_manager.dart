import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ushop_web/routes/app_routs.dart';

import '../popups/app_popups.dart';

class NetworkManager extends GetxController {
  // instance creator
  static NetworkManager get instance => Get.find();

  // variabels
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectivityStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionState);
    super.onInit();
  }

  // based on the connectivity , the connectivity status will be changed
  Future<void> _updateConnectionState(List<ConnectivityResult> result) async {
    _connectivityStatus.value = result.first;

    if (_connectivityStatus.value == ConnectivityResult.none) {
      AppPopups.showWarningSnackBar(title: "No InterNet Connection", message: "please check your inter net connection");
    } else if (_connectivityStatus.value == ConnectivityResult.mobile || _connectivityStatus.value == ConnectivityResult.wifi) {
      Get.toNamed(AppRouts.dashboard);
    }
  }

  // check if there is network connection or not
  Future<bool> isNetworkConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result.contains(ConnectivityResult.none)) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  // onClose
  // close streem
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
