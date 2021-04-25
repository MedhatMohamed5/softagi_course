import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopCacheHelper {
  static SharedPreferences _sharedPreferences;

  ShopCacheHelper._();

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    @required String key,
    @required bool value,
  }) async {
    return await _sharedPreferences.setBool(key, value);
  }

  static bool getBoolean({
    @required String key,
  }) {
    return _sharedPreferences.getBool(key);
  }
}
