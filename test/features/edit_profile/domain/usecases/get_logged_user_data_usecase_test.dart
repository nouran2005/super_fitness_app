import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/domain/entities/logged_user_data_response_entity.dart';
import 'package:super_fitness_app/features/edit_profile/domain/repos/edit_profile_repo.dart';
import 'package:super_fitness_app/features/edit_profile/domain/usecases/get_logged_user_data_usecase.dart';

import 'get_logged_user_data_usecase_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late MockEditProfileRepo mockRepo;
  late GetLoggedUserDataUseCase useCase;

  setUp(() {
    mockRepo = MockEditProfileRepo();
    useCase = GetLoggedUserDataUseCase(mockRepo);
  });

  setUpAll(() {
    provideDummy<ApiResult<LoggedUserDataResponseEntity>>(
      SuccessApiResult<LoggedUserDataResponseEntity>(
        data: LoggedUserDataResponseEntity(),
      ),
    );
  });
  group('GetLoggedUserDataUseCase Tests', () {
    test('should return success when repo returns data', () async {
      final response = LoggedUserDataResponseEntity(message: "success");

      when(mockRepo.getLoggedUserData()).thenAnswer(
        (_) async =>
            SuccessApiResult<LoggedUserDataResponseEntity>(data: response),
      );

      final result = await useCase.getLoggedUserData();

      expect(result, isA<SuccessApiResult<LoggedUserDataResponseEntity>>());
      expect((result as SuccessApiResult).data.message, "success");

      verify(mockRepo.getLoggedUserData()).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should return error when repo fails', () async {
      when(mockRepo.getLoggedUserData()).thenAnswer(
        (_) async => ErrorApiResult<LoggedUserDataResponseEntity>(
          error: "failed to fetch user",
        ),
      );

      final result = await useCase.getLoggedUserData();

      expect(result, isA<ErrorApiResult<LoggedUserDataResponseEntity>>());
      expect((result as ErrorApiResult).error, "failed to fetch user");

      verify(mockRepo.getLoggedUserData()).called(1);
    });
  });
}
