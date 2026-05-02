import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/changePassword/data/model/request/changepassRequest.dart';
import 'package:super_fitness_app/features/changePassword/data/model/response/change_password_response.dart';

void main() {
  group('ChangePassword Models Tests', () {
    group('ChangePasswordRequest', () {
      test('should serialize to JSON correctly', () {
        final request = ChangePasswordRequest(password: 'old123', newPassword: 'new123');
        final json = request.toJson();

        expect(json['password'], 'old123');
        expect(json['newPassword'], 'new123');
      });

      test('should deserialize from JSON correctly', () {
        final json = {'password': 'old123', 'newPassword': 'new123'};
        final request = ChangePasswordRequest.fromJson(json);

        expect(request.password, 'old123');
        expect(request.newPassword, 'new123');
      });
    });

    group('ChangePasswordResponse', () {
      test('should serialize to JSON correctly', () {
        final response = ChangePasswordResponse(message: 'Success', token: 'token123');
        final json = response.toJson();

        expect(json['message'], 'Success');
        expect(json['token'], 'token123');
      });

      test('should deserialize from JSON correctly', () {
        final json = {'message': 'Success', 'token': 'token123'};
        final response = ChangePasswordResponse.fromJson(json);

        expect(response.message, 'Success');
        expect(response.token, 'token123');
      });
    });
  });
}
