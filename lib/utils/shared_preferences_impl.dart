import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SharedPreferencesImp implements IPersistStore {
  SharedPreferences _sharedPreferences;

  @override
  Future<void> init() async {
    //Initialize the plugging
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Object read(String key) {
    try {
      return _sharedPreferences.getString(key);
    } catch (e) {
      throw PersistanceException('There is a problem in reading $key: $e');
    }
  }

  @override
  Future<void> write<T>(String key, T value) async {
    try {
      return _sharedPreferences.setString(key, value as String);
    } catch (e) {
      throw PersistanceException('There is a problem in writing $key: $e');
    }
  }

  @override
  Future<void> delete(String key) async {
    return _sharedPreferences.remove(key);
  }

  @override
  Future<void> deleteAll() {
    return _sharedPreferences.clear();
  }
}

class PersistanceException implements Exception {
  String _message;
  PersistanceException([String message = 'Unexpected Persistence Exception']) {
    this._message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
