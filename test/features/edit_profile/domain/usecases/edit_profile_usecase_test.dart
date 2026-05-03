import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:super_fitness_app/features/edit_profile/domain/entities/logged_user_data_response_entity.dart';
import 'package:super_fitness_app/features/edit_profile/domain/repos/edit_profile_repo.dart';
import 'package:super_fitness_app/features/edit_profile/domain/usecases/edit_profile_usecase.dart';

import 'edit_profile_usecase_test.mocks.dart';

@GenerateMocks([EditProfileRepo])
void main() {
  late MockEditProfileRepo mockRepo;
  late EditProfileUseCase useCase;

  setUp(() {
    mockRepo = MockEditProfileRepo();
    useCase = EditProfileUseCase(mockRepo);
  });

  setUpAll(() {
    provideDummy<ApiResult<LoggedUserDataResponseEntity>>(
      SuccessApiResult<LoggedUserDataResponseEntity>(
        data: LoggedUserDataResponseEntity(),
      ),
    );
  });

  final requestModel = EditProfileRequestModel(
    firstName: "Ahmed",
    lastName: "Ali",
    email: "test@mail.com",
    weight: 70,
    goal: "fitness",
    activityLevel: "medium",
  );

  group('EditProfileUseCase Tests', () {
    test('should call repo.editProfile and return success result', () async {
      final response = LoggedUserDataResponseEntity(message: "success");

      when(mockRepo.editProfile(requestModel)).thenAnswer(
        (_) async =>
            SuccessApiResult<LoggedUserDataResponseEntity>(data: response),
      );

      final result = await useCase.editProfile(requestModel);

      expect(result, isA<SuccessApiResult<LoggedUserDataResponseEntity>>());
      expect((result as SuccessApiResult).data.message, "success");

      verify(mockRepo.editProfile(requestModel)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should return error when repo fails', () async {
      when(mockRepo.editProfile(requestModel)).thenAnswer(
        (_) async => ErrorApiResult<LoggedUserDataResponseEntity>(
          error: "update failed",
        ),
      );

      final result = await useCase.editProfile(requestModel);

      expect(result, isA<ErrorApiResult<LoggedUserDataResponseEntity>>());
      expect((result as ErrorApiResult).error, "update failed");

      verify(mockRepo.editProfile(requestModel)).called(1);
    });
  });
}
