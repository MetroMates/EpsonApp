import 'package:shared_preferences/shared_preferences.dart';

final class StorageService {
  static late final SharedPreferences _pref;

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future<bool> save<T extends Object>({
    required String key,
    required T value,
  }) async {
    assert(key.isNotEmpty, 'Key는 빈값일 수 없습니다.');

    if (value is int) {
      return await _pref.setInt(key, value);
    }

    if (value is double) {
      return await _pref.setDouble(key, value);
    }

    if (value is String) {
      return await _pref.setString(key, value);
    }

    if (value is List<String>) {
      return await _pref.setStringList(key, value);
    }

    if (value is bool) {
      return await _pref.setBool(key, value);
    }

    return false;
  }

  static Future<T?> read<T extends Object>({
    required String key,
  }) async {
    assert(key.isNotEmpty, 'Key는 빈값일 수 없습니다.');

    if (T == String) {
      return _pref.getString(key) as T?;
    } else if (T == int) {
      return _pref.getInt(key) as T?;
    } else if (T == double) {
      return _pref.getDouble(key) as T?;
    } else if (T == bool) {
      return _pref.getBool(key) as T?;
    } else if (T == List<String>) {
      return _pref.getStringList(key) as T?;
    } else {
      throw UnsupportedError('Unsupported type');
    }
  }
}
