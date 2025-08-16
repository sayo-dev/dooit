import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseModel {
  Map toJson();
}

class LocalStorage {
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> writeBool(String key, bool value) async {
    try {
      return await _sharedPreferences.setBool(key, value);
    } catch (_) {
      return value;
    }
  }

  static bool? readBool(String key) {
    try {
      return _sharedPreferences.getBool(key);
    } catch (_) {
      return null;
    }
  }

  static Future<void> writeString(String key, String value) async {
    try {
      await _sharedPreferences.setString(key, value);
    } catch (_) {}
  }

  static String? readString(String key) {
    try {
      return _sharedPreferences.getString(key);
    } catch (_) {
      return null;
    }
  }

  static Future<void> writeObjectList<T extends BaseModel>(
    String key,
    List<T> values,
  ) async {
    try {
      final jsonList = values.map((item) => item.toJson()).toList();
      await _sharedPreferences.setString(key, jsonEncode(jsonList));
    } catch (_) {}
  }

  static List<T> readObjectList<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      final jsonString = _sharedPreferences.getString(key);
      if (jsonString == null) return [];

      final List decodedList = jsonDecode(jsonString);
      return decodedList.map((map) => fromJson(map)).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> deleteString(String key) async {
    try {
      await _sharedPreferences.remove(key);
    } catch (_) {}
  }

  static Future<bool> clearAll() async {
    try {
      return await _sharedPreferences.clear();
    } catch (_) {
      return false;
    }
  }

  static Future<bool> clearAllExcept(String keepKey) async {
    try {
      for (String key in _sharedPreferences.getKeys()) {
        if (key != keepKey) {
          await _sharedPreferences.remove(key);
        }
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> clearOnly(String key) async {
    try {
      return await _sharedPreferences.remove(key);
    } catch (_) {
      return false;
    }
  }
}
