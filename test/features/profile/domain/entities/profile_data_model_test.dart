import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';

void main() {
  test('ProfileDataModel properties', () {
    final model = ProfileDataModel(
      message: 'Success',
      error: null,
      user: ProfileUserModel(
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
        photo: 'photo_url',
        createdAt: '2023-01-01',
      ),
    );

    expect(model.user?.id, '123');
    expect(model.user?.firstName, 'John');
    expect(model.user?.lastName, 'Doe');
    expect(model.user?.email, 'john@example.com');
    expect(model.user?.gender, 'male');
    expect(model.user?.age, 25);
    expect(model.user?.weight, 70);
    expect(model.user?.height, 175);
    expect(model.user?.activityLevel, 'intermediate');
    expect(model.user?.goal, 'loseWeight');
    expect(model.user?.photo, 'photo_url');
    expect(model.user?.createdAt, '2023-01-01');
  });
}
