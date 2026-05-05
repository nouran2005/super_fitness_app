import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/signin/data/models/response/signin_response.dart';
import 'package:super_fitness_app/features/signin/data/models/response/user.dart';

void main() {
  group('SigninResponse Tests', () {
    test('fromJson should parse correctly', () {
      final json = {
        "message": "success",
        "token": "12345",
        "user": {"_id": "1", "firstName": "Ahmed", "lastName": "Ali"},
      };

      final result = SigninResponse.fromJson(json);

      expect(result.message, "success");
      expect(result.token, "12345");
      expect(result.user?.id, "1");
      expect(result.user?.firstName, "Ahmed");
      expect(result.user?.lastName, "Ali");
    });

    test('toJson should return correct map', () {
      final response = SigninResponse(
        message: "success",
        token: "12345",
        user: User(id: "1", firstName: "Ahmed", lastName: "Ali"),
      );

      final json = response.toJson();

      final userJson = (json["user"] as User).toJson();

      expect(json["message"], "success");
      expect(json["token"], "12345");
      expect(userJson["_id"], "1");
      expect(userJson["firstName"], "Ahmed");
      expect(userJson["lastName"], "Ali");
    });

    test('toSigninEntity should map correctly', () {
      final response = SigninResponse(
        user: User(id: "1", firstName: "Ahmed", lastName: "Ali"),
      );

      final entity = response.toSigninEntity();

      expect(entity.id, "1");
      expect(entity.firstName, "Ahmed");
      expect(entity.lastName, "Ali");
    });

    test('toSigninEntity should return empty strings when user is null', () {
      final response = SigninResponse(user: null);

      final entity = response.toSigninEntity();

      expect(entity.id, "");
      expect(entity.firstName, "");
      expect(entity.lastName, "");
    });
  });
}
