import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/data/models/response/signup_dto.dart';
import 'package:super_fitness_app/features/auth/data/models/response/user_dto.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_model.dart';

void main() {
  // ─── UserModelDto ────────────────────────────────────────────────────────────
  group('UserModelDto', () {
    const tId = 'user123';
    const tFirstName = 'John';
    const tLastName = 'Doe';
    const tEmail = 'john@example.com';
    const tGender = 'male';
    const tHeight = 175;
    const tWeight = 70;
    const tRole = 'user';

    final tUserDto = UserModelDto(
      id: tId,
      firstName: tFirstName,
      lastName: tLastName,
      email: tEmail,
      gender: tGender,
      height: tHeight,
      weight: tWeight,
      role: tRole,
    );

    test('should be a valid UserModelDto instance', () {
      expect(tUserDto, isA<UserModelDto>());
    });

    test('fromJson should return a valid model', () {
      final Map<String, dynamic> json = {
        '_id': tId,
        'firstName': tFirstName,
        'lastName': tLastName,
        'email': tEmail,
        'gender': tGender,
        'height': tHeight,
        'weight': tWeight,
        'role': tRole,
      };

      final result = UserModelDto.fromJson(json);

      expect(result.id, tId);
      expect(result.firstName, tFirstName);
      expect(result.lastName, tLastName);
      expect(result.email, tEmail);
      expect(result.gender, tGender);
      expect(result.height, tHeight);
      expect(result.weight, tWeight);
      expect(result.role, tRole);
    });

    test('toJson should return a JSON map containing proper data', () {
      final result = tUserDto.toJson();

      expect(result['_id'], tId);
      expect(result['firstName'], tFirstName);
      expect(result['lastName'], tLastName);
      expect(result['email'], tEmail);
      expect(result['gender'], tGender);
      expect(result['height'], tHeight);
      expect(result['weight'], tWeight);
      expect(result['role'], tRole);
    });
  });

  // ─── SignupDto ───────────────────────────────────────────────────────────────
  group('SignupDto', () {
    const tMessage = 'Registration successful';
    const tToken = 'jwt_token_123';

    final tUserDto = UserModelDto(
      id: 'user123',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      gender: 'male',
      height: 175,
      weight: 70,
      role: 'user',
    );

    final tSignupDto = SignupDto(
      message: tMessage,
      token: tToken,
      user: tUserDto,
    );

    test('should be a valid SignupDto instance', () {
      expect(tSignupDto, isA<SignupDto>());
    });

    test('fromJson should return a valid model', () {
      final Map<String, dynamic> json = {
        'message': tMessage,
        'token': tToken,
        'user': {
          '_id': 'user123',
          'firstName': 'John',
          'lastName': 'Doe',
          'email': 'john@example.com',
          'gender': 'male',
          'height': 175,
          'weight': 70,
          'role': 'user',
        },
      };

      final result = SignupDto.fromJson(json);

      expect(result.message, tMessage);
      expect(result.token, tToken);
      expect(result.user?.firstName, 'John');
      expect(result.user?.email, 'john@example.com');
    });

    test('toSignupModel should correctly map to SignupModel', () {
      final result = tSignupDto.toSignupModel();

      expect(result, isA<SignupModel>());
      expect(result.id, 'user123');
      expect(result.firstName, 'John');
      expect(result.lastName, 'Doe');
      expect(result.email, 'john@example.com');
      expect(result.gender, 'male');
      expect(result.height, 175);
      expect(result.weight, 70);
    });

    test(
      'toSignupModel with null user should return SignupModel with null fields',
      () {
        final dtoWithNullUser = SignupDto(message: 'ok', token: 'tok');
        final result = dtoWithNullUser.toSignupModel();

        expect(result, isA<SignupModel>());
        expect(result.id, isNull);
        expect(result.firstName, isNull);
      },
    );
  });
}
