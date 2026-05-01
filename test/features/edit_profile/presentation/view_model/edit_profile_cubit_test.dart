import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/edit_profile/domain/entities/logged_user_data_response_entity.dart';
import 'package:super_fitness_app/features/edit_profile/domain/usecases/edit_profile_usecase.dart';
import 'package:super_fitness_app/features/edit_profile/domain/usecases/get_logged_user_data_usecase.dart';
import 'package:super_fitness_app/features/edit_profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_cubit.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_events.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/view_model/edit_profile_state.dart';

import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([
  GetLoggedUserDataUseCase,
  EditProfileUseCase,
  UploadProfileImageUseCase,
])
void main() {
  late MockGetLoggedUserDataUseCase mockGetLoggedUserDataUseCase;
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockUploadProfileImageUseCase mockUploadProfileImageUseCase;
  late EditProfileCubit cubit;

  const tUser = LoggedUserEntity(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@example.com',
    weight: 75,
    activityLevel: 'level2',
    goal: 'Lose weight',
    photo: '',
  );

  final tResponseEntity = LoggedUserDataResponseEntity(
    message: 'success',
    user: tUser,
  );

  const tErrorMessage = 'Something went wrong';

  setUp(() {
    mockGetLoggedUserDataUseCase = MockGetLoggedUserDataUseCase();
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockUploadProfileImageUseCase = MockUploadProfileImageUseCase();

    provideDummy<ApiResult<LoggedUserDataResponseEntity>>(
      SuccessApiResult(data: tResponseEntity),
    );
    provideDummy<ApiResult<String>>(SuccessApiResult(data: ''));

    cubit = EditProfileCubit(
      mockEditProfileUseCase,
      mockGetLoggedUserDataUseCase,
      mockUploadProfileImageUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('EditProfileCubit', () {
    test('initial state has Resource.initial for getLoggedUserData', () {
      expect(cubit.state.getLoggedUserData.isInitial, true);
      expect(cubit.state.originalUser, isNull);
      expect(cubit.state.updatedUser, isNull);
      expect(cubit.state.isSavingData, false);
      expect(cubit.state.isPhotoUploading, false);
      expect(cubit.state.isFormValid, true);
      expect(cubit.state.saveError, isNull);
    });

    group('isSaveEnabled', () {
      test('returns false when originalUser == updatedUser (no changes)', () {
        expect(cubit.isSaveEnabled, false);
      });

      test('returns false while isSavingData is true even with changes', () {
        cubit.emit(
          EditProfileState(
            getLoggedUserData: Resource.success(tResponseEntity),
            originalUser: tUser,
            updatedUser: tUser.copyWith(firstName: 'Jane'),
            isSavingData: true,
            isFormValid: true,
          ),
        );
        expect(cubit.isSaveEnabled, false);
      });

      test('returns false when form is invalid', () {
        cubit.emit(
          EditProfileState(
            getLoggedUserData: Resource.success(tResponseEntity),
            originalUser: tUser,
            updatedUser: tUser.copyWith(firstName: 'Jane'),
            isFormValid: false,
          ),
        );
        expect(cubit.isSaveEnabled, false);
      });

      test(
        'returns true when there are changes, form is valid and not saving',
        () {
          cubit.emit(
            EditProfileState(
              getLoggedUserData: Resource.success(tResponseEntity),
              originalUser: tUser,
              updatedUser: tUser.copyWith(firstName: 'Jane'),
              isFormValid: true,
              isSavingData: false,
            ),
          );
          expect(cubit.isSaveEnabled, true);
        },
      );
    });

    group('GetLoggedUserDataProcessEvent', () {
      test(
        'emits [loading, success] and seeds both user copies on success',
        () async {
          when(
            mockGetLoggedUserDataUseCase.getLoggedUserData(),
          ).thenAnswer((_) async => SuccessApiResult(data: tResponseEntity));

          expectLater(
            cubit.stream,
            emitsInOrder([
              isA<EditProfileState>().having(
                (s) => s.getLoggedUserData.isLoading,
                'isLoading',
                true,
              ),
              isA<EditProfileState>()
                  .having(
                    (s) => s.getLoggedUserData.isSuccess,
                    'isSuccess',
                    true,
                  )
                  .having((s) => s.originalUser, 'originalUser', tUser)
                  .having((s) => s.updatedUser, 'updatedUser', tUser)
                  .having((s) => s.isFormValid, 'isFormValid', true),
            ]),
          );

          cubit.onEvent(GetLoggedUserDataProcessEvent());
          await Future<void>.delayed(Duration.zero);
        },
      );

      test('emits [loading, error] when use case returns an error', () async {
        when(
          mockGetLoggedUserDataUseCase.getLoggedUserData(),
        ).thenAnswer((_) async => ErrorApiResult(error: tErrorMessage));

        expectLater(
          cubit.stream,
          emitsInOrder([
            isA<EditProfileState>().having(
              (s) => s.getLoggedUserData.isLoading,
              'isLoading',
              true,
            ),
            isA<EditProfileState>()
                .having((s) => s.getLoggedUserData.isError, 'isError', true)
                .having(
                  (s) => s.getLoggedUserData.error,
                  'error',
                  tErrorMessage,
                ),
          ]),
        );

        cubit.onEvent(GetLoggedUserDataProcessEvent());
        await Future<void>.delayed(Duration.zero);
      });
    });

    group('UpdateLocalFieldEvent', () {
      setUp(() {
        cubit.emit(
          EditProfileState(
            getLoggedUserData: Resource.success(tResponseEntity),
            originalUser: tUser,
            updatedUser: tUser,
            isFormValid: true,
          ),
        );
      });

      test('updates updatedUser first name without touching originalUser', () {
        cubit.onEvent(
          UpdateLocalFieldEvent(firstName: 'Jane', isFormValid: true),
        );
        expect(cubit.state.updatedUser!.firstName, 'Jane');
        expect(cubit.state.originalUser!.firstName, 'John');
      });

      test('updates isFormValid in state', () {
        cubit.onEvent(UpdateLocalFieldEvent(isFormValid: false));
        expect(cubit.state.isFormValid, false);
      });

      test('does nothing when updatedUser is null', () {
        cubit.emit(EditProfileState(getLoggedUserData: Resource.initial()));
        cubit.onEvent(
          UpdateLocalFieldEvent(firstName: 'Jane', isFormValid: true),
        );
        expect(cubit.state.updatedUser, isNull);
      });
    });

    group('SaveChangesProcessEvent', () {
      setUp(() {
        cubit.emit(
          EditProfileState(
            getLoggedUserData: Resource.success(tResponseEntity),
            originalUser: tUser,
            updatedUser: tUser.copyWith(firstName: 'Jane'),
            isFormValid: true,
          ),
        );
      });

      test(
        'emits [saving=true, saving=false] and syncs originalUser on success',
        () async {
          when(
            mockEditProfileUseCase.editProfile(any),
          ).thenAnswer((_) async => SuccessApiResult(data: tResponseEntity));

          expectLater(
            cubit.stream,
            emitsInOrder([
              isA<EditProfileState>().having(
                (s) => s.isSavingData,
                'isSavingData=true',
                true,
              ),
              isA<EditProfileState>()
                  .having((s) => s.isSavingData, 'isSavingData=false', false)
                  .having(
                    (s) => s.originalUser!.firstName,
                    'originalUser synced',
                    'Jane',
                  )
                  .having((s) => s.saveError, 'saveError null', isNull),
            ]),
          );

          cubit.onEvent(SaveChangesProcessEvent());
          await Future<void>.delayed(Duration.zero);
        },
      );

      test('emits [saving=true, error] when save fails', () async {
        when(
          mockEditProfileUseCase.editProfile(any),
        ).thenAnswer((_) async => ErrorApiResult(error: tErrorMessage));

        expectLater(
          cubit.stream,
          emitsInOrder([
            isA<EditProfileState>().having(
              (s) => s.isSavingData,
              'isSavingData=true',
              true,
            ),
            isA<EditProfileState>()
                .having((s) => s.isSavingData, 'isSavingData=false', false)
                .having((s) => s.saveError, 'saveError set', tErrorMessage),
          ]),
        );

        cubit.onEvent(SaveChangesProcessEvent());
        await Future<void>.delayed(Duration.zero);
      });

      test('does nothing when isSaveEnabled is false', () async {
        cubit.emit(
          EditProfileState(
            getLoggedUserData: Resource.success(tResponseEntity),
            originalUser: tUser,
            updatedUser: tUser,
          ),
        );

        cubit.onEvent(SaveChangesProcessEvent());
        await Future<void>.delayed(Duration.zero);

        verifyNever(mockEditProfileUseCase.editProfile(any));
      });
    });

    group('UploadProfileImageProcessEvent', () {
      final tFile = File('test_photo.jpg');

      test('emits isPhotoUploading=true then re-fetches on success', () async {
        when(
          mockUploadProfileImageUseCase.uploadImage(any),
        ).thenAnswer((_) async => SuccessApiResult(data: 'photo_url'));

        when(
          mockGetLoggedUserDataUseCase.getLoggedUserData(),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponseEntity));

        final states = <EditProfileState>[];
        final sub = cubit.stream.listen(states.add);

        cubit.onEvent(UploadProfileImageProcessEvent(tFile));
        await Future<void>.delayed(Duration.zero);

        await sub.cancel();

        expect(states.any((s) => s.isPhotoUploading == true), true);
        verify(mockGetLoggedUserDataUseCase.getLoggedUserData()).called(1);
      });

      test(
        'emits isPhotoUploading=false and sets saveError on upload failure',
        () async {
          when(
            mockUploadProfileImageUseCase.uploadImage(any),
          ).thenAnswer((_) async => ErrorApiResult(error: tErrorMessage));

          expectLater(
            cubit.stream,
            emitsInOrder([
              isA<EditProfileState>().having(
                (s) => s.isPhotoUploading,
                'isPhotoUploading=true',
                true,
              ),
              isA<EditProfileState>()
                  .having(
                    (s) => s.isPhotoUploading,
                    'isPhotoUploading=false',
                    false,
                  )
                  .having((s) => s.saveError, 'saveError set', tErrorMessage),
            ]),
          );

          cubit.onEvent(UploadProfileImageProcessEvent(tFile));
          await Future<void>.delayed(Duration.zero);
        },
      );
    });

    group('EditProfileState.copyWith', () {
      test('clearSaveError resets saveError to null', () {
        cubit.emit(
          EditProfileState(
            getLoggedUserData: Resource.initial(),
            saveError: 'old error',
          ),
        );
        cubit.emit(cubit.state.copyWith(clearSaveError: true));
        expect(cubit.state.saveError, isNull);
      });

      test('preserves unchanged fields', () {
        cubit.emit(
          EditProfileState(
            getLoggedUserData: Resource.initial(),
            originalUser: tUser,
            isFormValid: false,
          ),
        );
        final next = cubit.state.copyWith(isSavingData: true);
        expect(next.originalUser, tUser);
        expect(next.isFormValid, false);
        expect(next.isSavingData, true);
      });
    });
  });
}
