import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class AuthStorage {
  static const _tokenKey = 'auth_token';
  static const _userKey = 'user_data';
  static const _rememberMeKey = 'remember_me';

  final SharedPreferences _prefs;
  AuthStorage(this._prefs);

  /////// Token
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    await _prefs.remove(_tokenKey);
  }

  //////// User
  Future<void> saveUserJson(String json) async {
    await _prefs.setString(_userKey, json);
  }

  String? getUserJson() {
    return _prefs.getString(_userKey);
  }

  Future<void> clearUser() async {
    await _prefs.remove(_userKey);
  }

  ///////// Remember me
  Future<void> setRememberMe(bool value) async {
    await _prefs.setBool(_rememberMeKey, value);
  }

  bool getRememberMe() {
    return _prefs.getBool(_rememberMeKey) ?? false;
  }

  /////// Clear all
  Future<void> clearAll() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_userKey);
    await _prefs.remove(_rememberMeKey);
  }
}
