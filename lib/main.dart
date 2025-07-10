import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:ushop_web/data/repositories/authentication/auth_repository.dart';
import 'app.dart';
import 'firebase_options.dart';

void main() async {
  //Todo : widget bindings
  WidgetsFlutterBinding.ensureInitialized();
  // final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //Todo : app services init
  // await Get.putAsync<RegisterTableColumnsServices>(() async => await RegisterTableColumnsServices().init());

  //Todo : local Storage initlaize
  await GetStorage.init();

  //Todo : set path url strategy
  setPathUrlStrategy();

  //Todo : await splash untel other items load

  //Todo : firebase intialize
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value) => Get.put(AuthRepository()));

  //Todo : App Entry point
  runApp(const App());
}
