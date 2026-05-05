import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';

void main() {
  group('SigninPostModel Tests', () {
    test('fromJson should parse correctly', () {
      final json = {"email": "test@mail.com", "password": "123456"};

      final model = SigninPostModel.fromJson(json);

      expect(model.email, "test@mail.com");
      expect(model.password, "123456");
    });

    test('toJson should return correct map', () {
      final model = SigninPostModel(email: "test@mail.com", password: "123456");

      final json = model.toJson();

      expect(json["email"], "test@mail.com");
      expect(json["password"], "123456");
    });

    test('fromJson should throw when missing required fields', () {
      final json = {"email": "test@mail.com"};

      expect(() => SigninPostModel.fromJson(json), throwsA(isA<TypeError>()));
    });
  });
}
