import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

abstract class LocalDatasource {
  Future<void> set(String key, Map<String, dynamic> value);
  Future<Map<String, dynamic>?> get(String key);
}

class LocalDatasourceImpl implements LocalDatasource {
  @override
  Future<Map<String, dynamic>?> get(String key) async {
    final instance = await SharedPreferences.getInstance();
    final response = instance.getString(key);
    return response != null ? jsonDecode(response) : null;
  }

  @override
  Future<bool> set(String key, Map<String, dynamic> value) async {
    final instance = await SharedPreferences.getInstance();
    return await instance.setString(key, jsonEncode(value));
  }
}
