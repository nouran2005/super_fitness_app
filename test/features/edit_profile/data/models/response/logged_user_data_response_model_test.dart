import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/response/logged_user_data_response_model.dart';

void main() {
  group('LoggedUserDataResponseModel Tests', () {
    final json = {
      "message": "success",
      "user": {
        "_id": "1",
        "firstName": "Ahmed",
        "lastName": "Ali",
        "email": "ahmed@test.com",
        "gender": "male",
        "age": 25,
        "weight": 70,
        "height": 175,
        "activityLevel": "medium",
        "goal": "fitness",
        "photo": "url",
        "createdAt": "2024-01-01",
        "passwordChangedAt": "2024-01-02",
        "resetCodeVerified": true,
      },
    };

    test('fromJson parses correctly', () {
      final model = LoggedUserDataResponseModel.fromJson(json);

      expect(model.message, "success");
      expect(model.user, isNotNull);
      expect(model.user!.id, "1");
      expect(model.user!.firstName, "Ahmed");
      expect(model.user!.lastName, "Ali");
      expect(model.user!.email, "ahmed@test.com");
      expect(model.user!.weight, 70);
      expect(model.user!.goal, "fitness");
      expect(model.user!.activityLevel, "medium");
    });

    test('toJson returns correct map', () {
      final model = LoggedUserDataResponseModel.fromJson(json);

      final result = model.toJson();

      expect(result["message"], "success");
      expect(result["user"], isA<LoggedUserModel>());

      final user = result["user"] as LoggedUserModel;

      expect(user.id, "1");
      expect(user.firstName, "Ahmed");
    });

    test('toEntity maps correctly', () {
      final model = LoggedUserDataResponseModel.fromJson(json);

      final entity = model.toEntity();

      expect(entity.message, "success");
      expect(entity.user, isNotNull);
      expect(entity.user!.firstName, "Ahmed");
      expect(entity.user!.lastName, "Ali");
      expect(entity.user!.email, "ahmed@test.com");
      expect(entity.user!.weight, 70);
      expect(entity.user!.goal, "fitness");
    });

    test('handles null user', () {
      final model = LoggedUserDataResponseModel.fromJson({
        "message": "success",
        "user": null,
      });

      expect(model.user, null);

      final entity = model.toEntity();
      expect(entity.user, null);
    });
  });

  group('LoggedUserModel Tests', () {
    final json = {
      "_id": "1",
      "firstName": "Ahmed",
      "lastName": "Ali",
      "email": "ahmed@test.com",
      "gender": "male",
      "age": 25,
      "weight": 70,
      "height": 175,
      "activityLevel": "medium",
      "goal": "fitness",
      "photo": "url",
      "createdAt": "2024-01-01",
      "passwordChangedAt": "2024-01-02",
      "resetCodeVerified": true,
    };

    test('fromJson parses user correctly', () {
      final user = LoggedUserModel.fromJson(json);

      expect(user.id, "1");
      expect(user.firstName, "Ahmed");
      expect(user.lastName, "Ali");
      expect(user.email, "ahmed@test.com");
      expect(user.resetCodeVerified, true);
    });

    test('toJson returns correct user map', () {
      final user = LoggedUserModel.fromJson(json);

      final result = user.toJson();

      expect(result["_id"], "1");
      expect(result["firstName"], "Ahmed");
      expect(result["email"], "ahmed@test.com");
    });

    test('toEntity maps correctly', () {
      final user = LoggedUserModel.fromJson(json);

      final entity = user.toEntity();

      expect(entity.firstName, "Ahmed");
      expect(entity.lastName, "Ali");
      expect(entity.email, "ahmed@test.com");
      expect(entity.weight, 70);
      expect(entity.goal, "fitness");
    });
  });
}
