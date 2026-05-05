import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/core/utils/validations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('Validations Utils', () {
    test('validatePassword checks rules', () {
      expect(Validations.validatePassword(null), isNotNull);
      expect(Validations.validatePassword('short'), isNotNull);
      expect(Validations.validatePassword('nouppercase1!'), isNotNull);
      expect(Validations.validatePassword('NOLOWERCASE1!'), isNotNull);
      expect(Validations.validatePassword('NoNumbers!'), isNotNull);
      expect(Validations.validatePassword('NoSpecialChar1'), isNotNull);
      expect(Validations.validatePassword('ValidPass1!'), isNull);
    });

    test('validatePasswordVerification checks match', () {
      expect(Validations.validatePasswordVerification(null, 'pass'), isNotNull);
      expect(Validations.validatePasswordVerification('wrong', 'pass'), isNotNull);
      expect(Validations.validatePasswordVerification('pass', 'pass'), isNull);
    });

    test('validateLoginPassword checks empty', () {
      expect(Validations.validateLoginPassword(null), isNotNull);
      expect(Validations.validateLoginPassword(''), isNotNull);
      expect(Validations.validateLoginPassword('pass'), isNull);
    });

    test('validatePhoneNumber checks length', () {
      expect(Validations.validatePhoneNumber(null, 10), isNotNull);
      expect(Validations.validatePhoneNumber('123', 10), isNotNull);
      expect(Validations.validatePhoneNumber('0123456789', 10), isNull);
    });

    test('validateName checks length and empty', () {
      expect(Validations.validateName(null), isNotNull);
      expect(Validations.validateName('A'), isNotNull);
      expect(Validations.validateName('John'), isNull);
    });

    test('validateEmpty checks empty', () {
      expect(Validations.validateEmpty(null), isNotNull);
      expect(Validations.validateEmpty(''), isNotNull);
      expect(Validations.validateEmpty('text'), isNull);
    });

    test('validatePin checks exact length', () {
      expect(Validations.validatePin(null, 4), isNotNull);
      expect(Validations.validatePin('123', 4), isNotNull);
      expect(Validations.validatePin('12345', 4), isNotNull);
      expect(Validations.validatePin('1234', 4), isNull);
    });

    test('validateUserImage checks null', () {
      expect(Validations.validateUserImage(null), isNotNull);
      expect(Validations.validateUserImage(File('dummy.png')), isNull);
    });

    test('validateArabicName checks empty', () {
      expect(Validations.validateArabicName(null), isNotNull);
      expect(Validations.validateArabicName('أحمد'), isNull);
    });

    test('validateEnglishName checks empty', () {
      expect(Validations.validateEnglishName(null), isNotNull);
      expect(Validations.validateEnglishName('Ahmed'), isNull);
    });

    test('validateEmail checks validity', () {
      expect(Validations.validateEmail(null), isNotNull);
      expect(Validations.validateEmail('invalid'), isNotNull);
      expect(Validations.validateEmail('test@test.com'), isNull);
    });

    test('validateUserName checks empty', () {
      expect(Validations.validateUserName(null), isNotNull);
      expect(Validations.validateUserName('user'), isNull);
    });
  });
}
