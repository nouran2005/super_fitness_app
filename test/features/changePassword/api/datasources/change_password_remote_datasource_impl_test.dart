import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/changePassword/api/datasources/change_password_remote_datasource_impl.dart';
import 'package:super_fitness_app/features/changePassword/data/model/request/changepassRequest.dart';
import 'package:super_fitness_app/features/changePassword/data/model/response/change_password_response.dart';

import 'change_password_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late ChangePasswordRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = ChangePasswordRemoteDataSourceImpl(mockApiClient);
  });

  group('ChangePasswordRemoteDataSourceImpl Tests', () {
    final request = ChangePasswordRequest(password: "old", newPassword: "new");
    final response = ChangePasswordResponse(message: "Success");

    test('should return SuccessApiResult when ApiClient call is successful', () async {
      when(mockApiClient.changePassword(any)).thenAnswer(
        (_) async => HttpResponse(
          response,
          Response(
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
          ),
        ),

      );

      final result = await dataSource.changePassword(request);

      expect(result, isA<SuccessApiResult<ChangePasswordResponse>>());
      verify(mockApiClient.changePassword(request)).called(1);
    });

    test('should return ErrorApiResult when ApiClient call throws DioException', () async {
      when(mockApiClient.changePassword(any)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          message: "Network error",
          type: DioExceptionType.connectionError,
        ),
      );

      final result = await dataSource.changePassword(request);

      expect(result, isA<ErrorApiResult<ChangePasswordResponse>>());
      verify(mockApiClient.changePassword(request)).called(1);
    });
  });
}
