import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/profile/data/models/response/profile_data_dto.dart';

void main() {
  group('ProfileDataDto', () {
    final tUserDtoJson = {
      '_id': '123',
      'firstName': 'John',
      'lastName': 'Doe',
      'email': 'john@example.com',
      'gender': 'male',
      'age': 25,
      'weight': 70,
      'height': 175,
      'activityLevel': 'intermediate',
      'goal': 'loseWeight',
      'photo': 'http://photo.com/1',
      'createdAt': '2023-01-01',
      'resetCodeVerified': true,
    };

    final tProfileDtoJson = {
      'message': 'Success',
      'user': tUserDtoJson,
      'error': null,
    };

    test('should return a valid model from JSON', () {
      final result = ProfileDataDto.fromJson(tProfileDtoJson);

      expect(result.message, 'Success');
      expect(result.user?.id, '123');
      expect(result.user?.firstName, 'John');
      expect(result.user?.lastName, 'Doe');
      expect(result.user?.email, 'john@example.com');
      expect(result.user?.gender, 'male');
      expect(result.user?.age, 25);
      expect(result.user?.weight, 70);
      expect(result.user?.height, 175);
      expect(result.user?.activityLevel, 'intermediate');
      expect(result.user?.goal, 'loseWeight');
      expect(result.user?.photo, 'http://photo.com/1');
      expect(result.user?.createdAt, '2023-01-01');
      expect(result.user?.resetCodeVerified, true);
    });

    test('should return a JSON map containing proper data', () {
      final dto = ProfileDataDto(
        message: 'Success',
        user: ProfileUserDto(
          id: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          gender: 'male',
          age: 25,
          weight: 70,
          height: 175,
          activityLevel: 'intermediate',
          goal: 'loseWeight',
          photo: 'http://photo.com/1',
          createdAt: '2023-01-01',
          resetCodeVerified: true,
        ),
        error: '',
      );

      final result = dto.toJson();

      final expectedUser = {
        '_id': '123',
        'firstName': 'John',
        'lastName': 'Doe',
        'email': 'john@example.com',
        'gender': 'male',
        'age': 25,
        'weight': 70,
        'height': 175,
        'activityLevel': 'intermediate',
        'goal': 'loseWeight',
        'photo': 'http://photo.com/1',
        'createdAt': '2023-01-01',
        'resetCodeVerified': true,
      };

      expect(result['message'], 'Success');
      expect(result['error'], '');

      // 🔥 الحل هنا
      expect((result['user'] as ProfileUserDto).toJson(), expectedUser);
    });
  });
}
