import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stay_match/core/utils/secure_storage_keys.dart';

class SecureStorageHelper extends ChangeNotifier {
  FlutterSecureStorage storage = FlutterSecureStorage();



  Future<void> addToSecureStorage({
    required String key,
    required String? value,
  }) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> readFromSecureStorage({required String key}) async {
    var value = await storage.read(key: key);
    return value;
  }

  Future<String?> getUserToken() async {
    return await readFromSecureStorage(key: SecureStorageKeys.tokenKey);
  }
}