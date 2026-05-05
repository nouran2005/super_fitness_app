import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/changePassword/data/model/request/changepassRequest.dart';
import 'package:super_fitness_app/features/changePassword/data/model/response/change_password_response.dart';
import 'package:super_fitness_app/features/changePassword/domain/repositories/change_password_repository.dart';
import 'package:super_fitness_app/features/changePassword/domain/use_cases/change_password_usecase.dart';

import 'change_password_usecase_test.mocks.dart';

@GenerateMocks([ChangePasswordRepository])
void main() {
  provideDummy<ApiResult<ChangePasswordResponse>>(
    SuccessApiResult(data: ChangePasswordResponse()),
  );
  late ChangePasswordUseCase useCase;

  late MockChangePasswordRepository mockRepository;

  setUp(() {
    mockRepository = MockChangePasswordRepository();
    useCase = ChangePasswordUseCase(mockRepository);
  });

  group('ChangePasswordUseCase Tests', () {
    final request = ChangePasswordRequest(password: "old", newPassword: "new");
    final response = ChangePasswordResponse(message: "Success");

    test(
      'should call changePassword on repository and return success',
      () async {
        when(
          mockRepository.changePassword(any),
        ).thenAnswer((_) async => SuccessApiResult(data: response));

        final result = await useCase.execute(request);

        expect(result, isA<SuccessApiResult<ChangePasswordResponse>>());
        verify(mockRepository.changePassword(request)).called(1);
      },
    );

    test('should return error when repository fails', () async {
      when(
        mockRepository.changePassword(any),
      ).thenAnswer((_) async => ErrorApiResult(error: "Error"));

      final result = await useCase.execute(request);

      expect(result, isA<ErrorApiResult<ChangePasswordResponse>>());
      verify(mockRepository.changePassword(request)).called(1);
    });
  });
}
