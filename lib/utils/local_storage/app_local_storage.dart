import 'package:get_storage/get_storage.dart';

class AppLocalStorage {
  //creating instance of GetStorage
  late final GetStorage _storage;

  // creating internal instance
  static AppLocalStorage? _instance;

  //the class can't be instanciated
  AppLocalStorage._internal();

  factory AppLocalStorage.instance() {
    _instance ??= AppLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = AppLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

//! ---> save data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

//! ---> read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

//! ---> remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

//! ---> clear all data
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
