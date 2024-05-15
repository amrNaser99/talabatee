import 'dart:convert';
import 'dart:developer';
import 'package:talabatee/blocs/app_cubit/app_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TransType { attend, leave }

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static const String userTokenKey = 'userTokenKey';

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();

    log('-- C A C H E  H E L P E R  I N I T   ');
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      return await sharedPreferences.setStringList(key, value);
    } else {
      return await sharedPreferences.setString(key, value.toString());
    }
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static int? getInt({
    required String key,
  }) {
    return sharedPreferences.getInt(key);
  }

  static dynamic saveObject({
    required String key,
    required dynamic value,
  }) async {
    return await sharedPreferences.setString(key, jsonEncode(value));
  }

  static dynamic getObject({
    required String key,
  }) {
    return sharedPreferences.get(jsonDecode(key)) as Map<String, dynamic>;
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearPrefs() async {
    return await sharedPreferences.clear();
  }
}
