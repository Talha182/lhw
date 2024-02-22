import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../FloorDatabase/entity/user.dart';

class UserManager {
  final _storage = const FlutterSecureStorage();
  static const _userKey = 'userData';

  Future<void> saveUser(User user) async {
    String userJson = json.encode(user.toJson());
    await _storage.write(key: _userKey, value: userJson);
  }

  Future<User?> getCurrentUser() async {
    String? userJson = await _storage.read(key: _userKey);
    if (userJson == null) return null;

    Map<String, dynamic> userMap = json.decode(userJson);
    return User.fromJson(userMap);
  }

  Future<void> logoutUser() async {
    await _storage.delete(key: _userKey);
  }

  Future<bool> isLoggedIn() async {
    String? userJson = await _storage.read(key: _userKey);
    return userJson != null;
  }
}
