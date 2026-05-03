import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/signin/data/models/response/user.dart';

void main() {
  group('User Model Tests', () {
    test('fromJson should parse correctly', () {
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
        "createdAt": "2024-01-01T12:00:00.000Z",
      };

      final user = User.fromJson(json);

      expect(user.id, "1");
      expect(user.firstName, "Ahmed");
      expect(user.lastName, "Ali");
      expect(user.email, "ahmed@test.com");
      expect(user.gender, "male");
      expect(user.age, 25);
      expect(user.weight, 70);
      expect(user.height, 175);
      expect(user.activityLevel, "medium");
      expect(user.goal, "fitness");
      expect(user.photo, "url");
      expect(user.createdAt, DateTime.parse("2024-01-01T12:00:00.000Z"));
    });

    test('toJson should return correct map', () {
      final user = User(
        id: "1",
        firstName: "Ahmed",
        lastName: "Ali",
        email: "ahmed@test.com",
        gender: "male",
        age: 25,
        weight: 70,
        height: 175,
        activityLevel: "medium",
        goal: "fitness",
        photo: "url",
        createdAt: DateTime.parse("2024-01-01T12:00:00.000Z"),
      );

      final json = user.toJson();

      expect(json["_id"], "1");
      expect(json["firstName"], "Ahmed");
      expect(json["lastName"], "Ali");
      expect(json["email"], "ahmed@test.com");
      expect(json["gender"], "male");
      expect(json["age"], 25);
      expect(json["weight"], 70);
      expect(json["height"], 175);
      expect(json["activityLevel"], "medium");
      expect(json["goal"], "fitness");
      expect(json["photo"], "url");
      expect(json["createdAt"], "2024-01-01T12:00:00.000Z");
    });

    test('fromJson should handle null values', () {
      final json = <String, dynamic>{};

      final user = User.fromJson(json);

      expect(user.id, null);
      expect(user.firstName, null);
      expect(user.lastName, null);
      expect(user.email, null);
      expect(user.gender, null);
      expect(user.age, null);
      expect(user.weight, null);
      expect(user.height, null);
      expect(user.activityLevel, null);
      expect(user.goal, null);
      expect(user.photo, null);
      expect(user.createdAt, null);
    });
  });
}
