import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/auth/data/models/response/logout_response.dart';

void main() {
  const message = 'message';
  const error = 'error';
  group('LogoutDto', () {
    final tUserDto = LogoutResponse(message: message, error: error);

    test('should be a valid LogoutDto instance', () {
      expect(tUserDto, isA<LogoutResponse>());
    });

    test('fromJson should return a valid model', () {
      final Map<String, dynamic> json = {'message': message, 'error': error};

      final result = LogoutResponse.fromJson(json);

      expect(result.message, message);
      expect(result.error, error);
    });

    test('toJson should return a JSON map containing proper data', () {
      final result = tUserDto.toJson();

      expect(result['message'], message);
      expect(result['error'], error);
    });
  });
}
