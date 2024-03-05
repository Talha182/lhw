import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';


class UserService {
  static const String _userKey = 'userData';

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = json.encode(user.toJson());
    await prefs.setString(_userKey, userJson);
    await prefs.setBool('isLoggedIn', true);
  }

  static Future<User?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);
    if (userJson != null) {
      return User.fromJson(json.decode(userJson));
    }
    return null;
  }

  static Future<int> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);
    if (userJson != null) {
      User user = User.fromJson(json.decode(userJson));
      return user.id;
    }
    return 0; // Consider throwing an error or returning null for better error handling
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.setBool('isLoggedIn', false);
  }

}
