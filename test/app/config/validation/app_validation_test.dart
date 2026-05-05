import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/app/config/validation/app_validation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('Validators', () {
    test('notEmpty returns true for non-empty string', () {
      expect(Validators.notEmpty('test'), isTrue);
    });

    test('notEmpty returns false for empty or null string', () {
      expect(Validators.notEmpty(''), isFalse);
      expect(Validators.notEmpty('   '), isFalse);
      expect(Validators.notEmpty(null), isFalse);
    });

    group('firstNameValidator', () {
      test('returns error for empty', () {
        expect(Validators.firstNameValidator(null), isNotNull);
        expect(Validators.firstNameValidator(''), isNotNull);
      });

      test('returns error for invalid name', () {
        expect(Validators.firstNameValidator('A'), isNotNull); // too short
        expect(
          Validators.firstNameValidator('John123!'),
          isNotNull,
        ); // special char
      });

      test('returns null for valid name', () {
        expect(Validators.firstNameValidator('John'), isNull);
        expect(Validators.firstNameValidator('Mary-Jane'), isNull);
      });
    });

    group('passwordValidator', () {
      test('returns error for empty password', () {
        expect(Validators.passwordValidator(null), isNotNull);
      });

      test('returns error for password without uppercase', () {
        expect(Validators.passwordValidator('pass123!'), isNotNull);
      });

      test('returns error for password without special character', () {
        expect(Validators.passwordValidator('Pass1234'), isNotNull);
      });

      test('returns null for strong password', () {
        expect(Validators.passwordValidator('StrongP@ss1'), isNull);
      });
    });

    group('emailValidator', () {
      test('returns error for empty email', () {
        expect(Validators.emailValidator(null), isNotNull);
      });

      test('returns error for invalid email', () {
        expect(Validators.emailValidator('invalid-email'), isNotNull);
        expect(Validators.emailValidator('test@.com'), isNotNull);
      });

      test('returns null for valid email', () {
        expect(Validators.emailValidator('test@example.com'), isNull);
      });
    });

    group('phoneValidator', () {
      test('returns error for empty phone', () {
        expect(Validators.phoneValidator(null), isNotNull);
      });

      test('returns error for invalid phone', () {
        expect(
          Validators.phoneValidator('01012345678'),
          isNotNull,
        ); // missing +2
        expect(
          Validators.phoneValidator('+201912345678'),
          isNotNull,
        ); // invalid prefix
      });

      test('returns null for valid phone', () {
        expect(Validators.phoneValidator('+201012345678'), isNull);
        expect(Validators.phoneValidator('+201112345678'), isNull);
      });
    });
  });
}
