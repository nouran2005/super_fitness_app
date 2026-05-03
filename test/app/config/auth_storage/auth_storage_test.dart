import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';

void main() {
  late AuthStorage authStorage;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    authStorage = AuthStorage();
  });

  group('AuthStorage', () {
    test('isFirstTimeUser returns true by default', () async {
      final isFirstTime = await authStorage.isFirstTimeUser();
      expect(isFirstTime, isTrue);
    });

    test('setNotFirstTime sets isFirstTime to false', () async {
      await authStorage.setNotFirstTime();
      final isFirstTime = await authStorage.isFirstTimeUser();
      expect(isFirstTime, isFalse);
    });

    test('saveToken and getToken work correctly', () async {
      await authStorage.saveToken('test_token');
      final token = await authStorage.getToken();
      expect(token, 'test_token');
    });

    test('clearToken removes the token', () async {
      await authStorage.saveToken('test_token');
      await authStorage.clearToken();
      final token = await authStorage.getToken();
      expect(token, isNull);
    });

    test('saveUserJson and getUserJson work correctly', () async {
      const userJson = '{"name":"John"}';
      await authStorage.saveUserJson(userJson);
      final retrievedJson = await authStorage.getUserJson();
      expect(retrievedJson, userJson);
    });

    test('clearUser removes user data', () async {
      await authStorage.saveUserJson('{"name":"John"}');
      await authStorage.clearUser();
      final retrievedJson = await authStorage.getUserJson();
      expect(retrievedJson, isNull);
    });

    test('getRememberMe returns false by default', () async {
      final rememberMe = await authStorage.getRememberMe();
      expect(rememberMe, isFalse);
    });

    test('setRememberMe works correctly', () async {
      await authStorage.setRememberMe(true);
      final rememberMe = await authStorage.getRememberMe();
      expect(rememberMe, isTrue);
    });

    test('clearAll removes token, user, and rememberMe flags', () async {
      await authStorage.saveToken('token');
      await authStorage.saveUserJson('{}');
      await authStorage.setRememberMe(true);

      await authStorage.clearAll();

      expect(await authStorage.getToken(), isNull);
      expect(await authStorage.getUserJson(), isNull);
      expect(await authStorage.getRememberMe(), isFalse);
    });
  });
}
