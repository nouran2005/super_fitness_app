import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/data/models/request/signup_request.dart';

void main() {
  const tFirstName = 'John';
  const tLastName = 'Doe';
  const tEmail = 'john@example.com';
  const tPassword = 'Password1!';
  const tRePassword = 'Password1!';
  const tGender = 'male';
  const tHeight = 175;
  const tWeight = 70;
  const tAge = 25;
  const tGoal = 'loseWeight';
  const tActivityLevel = 'intermediate';

  final tSignupRequest = SignupRequest(
    firstName: tFirstName,
    lastName: tLastName,
    email: tEmail,
    password: tPassword,
    rePassword: tRePassword,
    gender: tGender,
    height: tHeight,
    weight: tWeight,
    age: tAge,
    goal: tGoal,
    activityLevel: tActivityLevel,
  );

  group('SignupRequest', () {
    test('should be a valid SignupRequest instance', () {
      expect(tSignupRequest, isA<SignupRequest>());
    });

    test('fromJson should return a valid model', () {
      final Map<String, dynamic> json = {
        'firstName': tFirstName,
        'lastName': tLastName,
        'email': tEmail,
        'password': tPassword,
        'rePassword': tRePassword,
        'gender': tGender,
        'height': tHeight,
        'weight': tWeight,
        'age': tAge,
        'goal': tGoal,
        'activityLevel': tActivityLevel,
      };

      final result = SignupRequest.fromJson(json);

      expect(result.firstName, tFirstName);
      expect(result.lastName, tLastName);
      expect(result.email, tEmail);
      expect(result.password, tPassword);
      expect(result.rePassword, tRePassword);
      expect(result.gender, tGender);
      expect(result.height, tHeight);
      expect(result.weight, tWeight);
      expect(result.age, tAge);
      expect(result.goal, tGoal);
      expect(result.activityLevel, tActivityLevel);
    });

    test('toJson should return a JSON map containing proper data', () {
      final result = tSignupRequest.toJson();

      expect(result['firstName'], tFirstName);
      expect(result['lastName'], tLastName);
      expect(result['email'], tEmail);
      expect(result['password'], tPassword);
      expect(result['rePassword'], tRePassword);
      expect(result['gender'], tGender);
      expect(result['height'], tHeight);
      expect(result['weight'], tWeight);
      expect(result['age'], tAge);
      expect(result['goal'], tGoal);
      expect(result['activityLevel'], tActivityLevel);
    });

    test('fromJson with null fields should return model with null values', () {
      final Map<String, dynamic> json = {};
      final result = SignupRequest.fromJson(json);

      expect(result.firstName, isNull);
      expect(result.lastName, isNull);
      expect(result.email, isNull);
      expect(result.password, isNull);
    });
  });
}
