import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper extends ChangeNotifier {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static const String tokenKey = 'token';
  static const refreshTokenKey = 'refresh_token';
  static const userIdKey = 'user_id';
  static Future<void> addToSecureStorage({
    required String key,
    required String? value,
  }) async {
    await storage.write(key: key, value: value);
  }
  static Future<String?> readFromSecureStorage({required String key}) async {
    var value = await storage.read(key: key);
    return value;
  }

}