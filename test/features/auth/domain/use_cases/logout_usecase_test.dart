import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/data/models/response/logout_response.dart';
import 'package:super_fitness_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:super_fitness_app/features/auth/domain/use_cases/logout_usecase.dart';

import 'logout_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockRepository;
  late LogoutUsecase useCase;

  const token = 'token';
  const message = 'message';
  const error = 'error';

  final logoutModel = LogoutResponse(message: message, error: error);

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LogoutUsecase(mockRepository);
  });

  setUpAll(() {
    provideDummy<ApiResult<LogoutResponse>>(
      SuccessApiResult<LogoutResponse>(data: LogoutResponse()),
    );
  });

  group('LogoutUseCase.execute', () {
    test(
      'should delegate to repository.logout and return SuccessApiResult',
      () async {
        // arrange
        when(mockRepository.logout(token: token)).thenAnswer(
          (_) async => SuccessApiResult<LogoutResponse>(data: logoutModel),
        );

        // act
        final result = await useCase.call(token: token);

        // assert
        expect(result, isA<SuccessApiResult<LogoutResponse>>());
        expect((result as SuccessApiResult<LogoutResponse>).data, logoutModel);

        verify(mockRepository.logout(token: token)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'should return ErrorApiResult when repository returns an error',
      () async {
        // arrange
        const tError = 'Server error';
        when(
          mockRepository.logout(token: token),
        ).thenAnswer((_) async => ErrorApiResult(error: tError));

        // act
        final result = await useCase.call(token: token);

        // assert
        expect(result, isA<ErrorApiResult<LogoutResponse>>());
        expect((result as ErrorApiResult<LogoutResponse>).error, tError);
      },
    );
  });
}
