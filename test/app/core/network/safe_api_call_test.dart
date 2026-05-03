import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/network/safe_api_call.dart';

void main() {
  group('safeApiCall', () {
    test('returns SuccessApiResult for 2xx status codes', () async {
      final response = HttpResponse(
        'data',
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      final result = await safeApiCall(call: () async => response);

      expect(result, isA<SuccessApiResult<String>>());
      final success = result as SuccessApiResult<String>;
      expect(success.data, 'data');
    });

    test('returns ErrorApiResult for non-2xx status codes', () async {
      final response = HttpResponse(
        'data',
        Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 400,
        ),
      );

      final result = await safeApiCall(call: () async => response);

      expect(result, isA<ErrorApiResult<String>>());
      final error = result as ErrorApiResult<String>;
      expect(error.error, 'Failed with status code: 400');
    });

    test('returns ErrorApiResult on DioException with response data', () async {
      final result = await safeApiCall<String>(call: () async {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            requestOptions: RequestOptions(path: ''),
            data: {'error': 'Server error message'},
          ),
        );
      });

      expect(result, isA<ErrorApiResult<String>>());
      final error = result as ErrorApiResult<String>;
      expect(error.error, 'Server error message');
    });

    test('returns ErrorApiResult on generic exception', () async {
      final result = await safeApiCall<String>(call: () async {
        throw Exception('Something went wrong');
      });

      expect(result, isA<ErrorApiResult<String>>());
      final error = result as ErrorApiResult<String>;
      expect(error.error, 'Unexpected error: Exception: Something went wrong');
    });
  });
}
