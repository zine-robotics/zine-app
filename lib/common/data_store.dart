import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// This DataStore is created for setting up FlutterSecuredStorage.
/// The default functions are defined here to use the DataStore

abstract class DataStore {
  // DataStore(SharedPreferences sharedPreferences);
  DataStore(FlutterSecureStorage securedStorage);

  Future<void> setString(String key, String value);

  Future<String?> getString(String key);

  Future<void> delete({required String key});
}

class DefaultStore implements DataStore {
  // final SharedPreferences _sharedPreferences;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // DefaultStore(this._sharedPreferences);

  @override
  Future<void> setString(String key, String value) async {
    // await _sharedPreferences.setString(key, value);
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> getString(String key) async {
    // return _sharedPreferences.getString(key);
    return await _secureStorage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) async =>
      await _secureStorage.delete(key: key);
}
