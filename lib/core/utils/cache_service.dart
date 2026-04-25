import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  final SharedPreferences sharedPrefs;

  // Constructor بياخد الـ Instance جاهزة من GetIt
  CacheService({required this.sharedPrefs});

    String userNameKey = 'user-name';
    String userProfilePicKey = 'user_profile_pic';

  Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPrefs.setString(key, value);
    if (value is bool) return await sharedPrefs.setBool(key, value);
    if (value is double) return await sharedPrefs.setDouble(key, value);
    if (value is int) return await sharedPrefs.setInt(key, value);
    if (value is List<String>) return await sharedPrefs.setStringList(key, value);
    return false;
  }

  dynamic getData({required String key}) {
    return sharedPrefs.get(key);
  }

  Future<bool> deleteItem({required String key}) async {
    return await sharedPrefs.remove(key);
  }

  // ميزة إضافية: مسح كل الداتا عند الـ Logout
  Future<bool> clearAll() async {
    return await sharedPrefs.clear();
  }
}