import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';

void main() {
  group('EditProfileRequestModel Tests', () {
    test('fromJson should parse correctly', () {
      final json = {
        "firstName": "Ahmed",
        "lastName": "Ali",
        "email": "ahmed@test.com",
        "weight": 70,
        "goal": "fitness",
        "activityLevel": "medium",
      };

      final model = EditProfileRequestModel.fromJson(json);

      expect(model.firstName, "Ahmed");
      expect(model.lastName, "Ali");
      expect(model.email, "ahmed@test.com");
      expect(model.weight, 70);
      expect(model.goal, "fitness");
      expect(model.activityLevel, "medium");
    });

    test('toJson should return correct map', () {
      const model = EditProfileRequestModel(
        firstName: "Ahmed",
        lastName: "Ali",
        email: "ahmed@test.com",
        weight: 70,
        goal: "fitness",
        activityLevel: "medium",
      );

      final json = model.toJson();

      expect(json["firstName"], "Ahmed");
      expect(json["lastName"], "Ali");
      expect(json["email"], "ahmed@test.com");
      expect(json["weight"], 70);
      expect(json["goal"], "fitness");
      expect(json["activityLevel"], "medium");
    });

    test('fromJson should handle null values', () {
      final json = <String, dynamic>{};

      final model = EditProfileRequestModel.fromJson(json);

      expect(model.firstName, null);
      expect(model.lastName, null);
      expect(model.email, null);
      expect(model.weight, null);
      expect(model.goal, null);
      expect(model.activityLevel, null);
    });

    test('toJson should include null values', () {
      const model = EditProfileRequestModel();

      final json = model.toJson();

      expect(json.containsKey("firstName"), true);
      expect(json["firstName"], null);
    });
  });
}
