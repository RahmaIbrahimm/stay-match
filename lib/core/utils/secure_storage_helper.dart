import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static const String tokenKey = 'token';
  static String? token;

  static Future<void> addToSecureStorage({
    required String key,
    required String? value,
  }) async {
    await storage.write(key: key, value: value);
  }

  static Future<void> loadToken() async {
    token = await storage.read(key: tokenKey);
  }
  // todo: reset / refresh token

  // todo: delete token
}