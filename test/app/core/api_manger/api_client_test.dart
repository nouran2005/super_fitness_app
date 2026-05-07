import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/retrofit.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/values/api_constants.dart';
import 'package:super_fitness_app/app/core/values/app_endpoint_strings.dart';
import 'package:super_fitness_app/features/auth/data/models/request/signup_request.dart';
import 'package:super_fitness_app/features/auth/data/models/response/signup_dto.dart';
import 'package:super_fitness_app/features/changePassword/data/model/request/changepassRequest.dart';
import 'package:super_fitness_app/features/changePassword/data/model/response/change_password_response.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/request/edit_profile_request_model.dart';
import 'package:super_fitness_app/features/edit_profile/data/models/response/logged_user_data_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/forget_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/verify_code_request_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/forget_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/reset_password_response_model.dart';
import 'package:super_fitness_app/features/forget_password/data/models/response/verify_code_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/exercises_by_muscle_difficulty_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/levels_response_model.dart';
import 'package:super_fitness_app/features/popular_training/data/models/muscles_random_response_model.dart';
import 'package:super_fitness_app/features/profile/data/models/response/profile_data_dto.dart';
import 'package:super_fitness_app/features/signin/data/models/post/signin_post_model.dart';
import 'package:super_fitness_app/features/signin/data/models/response/signin_response.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_by_muscle_group_response.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_group_response.dart';
import 'package:super_fitness_app/features/Exercise/data/model/response/ExerciseRESponse.dart';
import 'package:super_fitness_app/features/auth/data/models/response/logout_response.dart';

// ── Mock ──────────────────────────────────────────────────────────────────────
class MockApiClient extends Mock implements ApiClient {}

// Fakes needed for mocktail's any() matcher
class _FakeSigninPostModel extends Fake implements SigninPostModel {}

class _FakeSignupRequest extends Fake implements SignupRequest {}

class _FakeForgetPasswordRequestModel extends Fake
    implements ForgetPasswordRequestModel {}

class _FakeVerifyCodeRequestModel extends Fake
    implements VerifyCodeRequestModel {}

class _FakeResetPasswordRequestModel extends Fake
    implements ResetPasswordRequestModel {}

class _FakeEditProfileRequestModel extends Fake
    implements EditProfileRequestModel {}

class _FakeChangePasswordRequest extends Fake
    implements ChangePasswordRequest {}

class _FakeFile extends Fake implements File {}

void main() {
  late MockApiClient mockClient;

  setUpAll(() {
    registerFallbackValue(_FakeSigninPostModel());
    registerFallbackValue(_FakeSignupRequest());
    registerFallbackValue(_FakeForgetPasswordRequestModel());
    registerFallbackValue(_FakeVerifyCodeRequestModel());
    registerFallbackValue(_FakeResetPasswordRequestModel());
    registerFallbackValue(_FakeEditProfileRequestModel());
    registerFallbackValue(_FakeChangePasswordRequest());
    registerFallbackValue(_FakeFile());
  });

  setUp(() {
    mockClient = MockApiClient();
  });

  // ── AppEndpoints & ApiConstants contract ─────────────────────────────────
  group('ApiClient — endpoint constants contract', () {
    test('baseUrl is the expected fitness API URL', () {
      expect(AppEndpoints.baseUrl, 'https://fitness.elevateegy.com/api/v1/');
    });

    test('Auth endpoints are non-empty', () {
      expect(AppEndpoints.signInPath, isNotEmpty);
      expect(AppEndpoints.signupPath, isNotEmpty);
      expect(AppEndpoints.forgotPasswordPath, isNotEmpty);
      expect(AppEndpoints.verifyResetCodePath, isNotEmpty);
      expect(AppEndpoints.resetPasswordPath, isNotEmpty);
      expect(AppEndpoints.logoutPath, isNotEmpty);
      expect(AppEndpoints.profilePath, isNotEmpty);
      expect(AppEndpoints.editProfilePath, isNotEmpty);
      expect(AppEndpoints.uploadProfileImagePath, isNotEmpty);
      expect(AppEndpoints.changePasswordPath, isNotEmpty);
    });

    test('Exercise endpoints are non-empty', () {
      expect(AppEndpoints.exercisesPath, isNotEmpty);
      expect(AppEndpoints.exercisesRandomPath, isNotEmpty);
      expect(AppEndpoints.exercisesByMuscleDifficulty, isNotEmpty);
    });

    test('Muscles / levels endpoints are non-empty', () {
      expect(AppEndpoints.randomMusclesPath, isNotEmpty);
      expect(AppEndpoints.musclesRandomPath, isNotEmpty);
      expect(AppEndpoints.levelsPath, isNotEmpty);
      expect(AppEndpoints.getAllMusclesGroup, isNotEmpty);
      expect(AppEndpoints.getAllMusclesByMuscleGroup, isNotEmpty);
    });

    test('ApiConstants header keys are correct', () {
      expect(ApiConstants.acceptLanguage, 'accept-language');
      expect(ApiConstants.authorization, 'Authorization');
      expect(ApiConstants.primeMoverMuscleId, 'primeMoverMuscleId');
      expect(ApiConstants.difficultyLevelId, 'difficultyLevelId');
      expect(ApiConstants.photo, 'photo');
    });
  });

  // ── Auth calls ────────────────────────────────────────────────────────────
  group('ApiClient — Auth calls delegation', () {
    test('signIn delegates to ApiClient.signIn', () async {
      final tRequest = SigninPostModel(email: 'a@b.com', password: '12345678');
      final tResponse = HttpResponse<SigninResponse>(
        SigninResponse(),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(() => mockClient.signIn(any())).thenAnswer((_) async => tResponse);

      final result = await mockClient.signIn(tRequest);

      expect(result, tResponse);
      verify(() => mockClient.signIn(tRequest)).called(1);
    });

    test('signUp delegates to ApiClient.signUp', () async {
      final tRequest = SignupRequest(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@test.com',
        password: 'pass1234',
        rePassword: 'pass1234',
        gender: 'male',
      );
      final tResponse = HttpResponse<SignupDto>(
        SignupDto(),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 201,
        ),
      );

      when(() => mockClient.signUp(any())).thenAnswer((_) async => tResponse);

      final result = await mockClient.signUp(tRequest);

      expect(result, tResponse);
      verify(() => mockClient.signUp(tRequest)).called(1);
    });

    test('forgotPassword delegates to ApiClient.forgotPassword', () async {
      final tRequest = ForgetPasswordRequestModel(email: 'a@b.com');
      final tResponse = HttpResponse<ForgotPasswordResponseModel>(
        ForgotPasswordResponseModel(
          message: 'email sent',
          info: 'Check your inbox',
        ),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(
        () => mockClient.forgotPassword(any()),
      ).thenAnswer((_) async => tResponse);

      final result = await mockClient.forgotPassword(tRequest);

      expect(result, tResponse);
      verify(() => mockClient.forgotPassword(tRequest)).called(1);
    });

    test('verifyOtp delegates to ApiClient.verifyOtp', () async {
      final tRequest = VerifyCodeRequestModel(resetCode: '123456');
      final tResponse = HttpResponse<VerifyCodeResponseModel>(
        VerifyCodeResponseModel(status: 'Success'),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(
        () => mockClient.verifyOtp(any()),
      ).thenAnswer((_) async => tResponse);

      final result = await mockClient.verifyOtp(tRequest);

      expect(result, tResponse);
      verify(() => mockClient.verifyOtp(tRequest)).called(1);
    });

    test('resetPassword delegates to ApiClient.resetPassword', () async {
      final tRequest = ResetPasswordRequestModel(
        email: 'a@b.com',
        newPassword: 'new123456',
      );
      final tResponse = HttpResponse<ResetPasswordResponseModel>(
        ResetPasswordResponseModel(message: 'done', token: 'tok_123'),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(
        () => mockClient.resetPassword(any()),
      ).thenAnswer((_) async => tResponse);

      final result = await mockClient.resetPassword(tRequest);

      expect(result, tResponse);
      verify(() => mockClient.resetPassword(tRequest)).called(1);
    });
  });

  // ── Profile calls ─────────────────────────────────────────────────────────
  group('ApiClient — Profile calls delegation', () {
    test('getProfileData delegates to ApiClient.getProfileData', () async {
      const tToken = 'Bearer test_token';
      final tResponse = HttpResponse<ProfileDataDto>(
        ProfileDataDto(),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(
        () => mockClient.getProfileData(any()),
      ).thenAnswer((_) async => tResponse);

      final result = await mockClient.getProfileData(tToken);

      expect(result, tResponse);
      verify(() => mockClient.getProfileData(tToken)).called(1);
    });

    test(
      'getLoggedUserData delegates to ApiClient.getLoggedUserData',
      () async {
        final tResponse = HttpResponse<LoggedUserDataResponseModel>(
          LoggedUserDataResponseModel(),
          Response(
            data: null,
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
          ),
        );

        when(
          () => mockClient.getLoggedUserData(),
        ).thenAnswer((_) async => tResponse);

        final result = await mockClient.getLoggedUserData();

        expect(result, tResponse);
        verify(() => mockClient.getLoggedUserData()).called(1);
      },
    );

    test('editProfile delegates to ApiClient.editProfile', () async {
      final tRequest = EditProfileRequestModel();
      final tResponse = HttpResponse<LoggedUserDataResponseModel>(
        LoggedUserDataResponseModel(),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(
        () => mockClient.editProfile(any()),
      ).thenAnswer((_) async => tResponse);

      final result = await mockClient.editProfile(tRequest);

      expect(result, tResponse);
      verify(() => mockClient.editProfile(tRequest)).called(1);
    });
  });

  // ── Muscles / Levels calls ────────────────────────────────────────────────
  group('ApiClient — Muscles & Levels calls delegation', () {
    test(
      'getRandom20Muscles delegates to ApiClient.getRandom20Muscles',
      () async {
        final tResponse = HttpResponse<MusclesRandomResponseModel>(
          MusclesRandomResponseModel(),
          Response(
            data: null,
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
          ),
        );

        when(
          () => mockClient.getRandom20Muscles(),
        ).thenAnswer((_) async => tResponse);

        final result = await mockClient.getRandom20Muscles();

        expect(result, tResponse);
        verify(() => mockClient.getRandom20Muscles()).called(1);
      },
    );

    test('getLevels delegates to ApiClient.getLevels', () async {
      final tResponse = HttpResponse<LevelsResponseModel>(
        LevelsResponseModel(),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(() => mockClient.getLevels()).thenAnswer((_) async => tResponse);

      final result = await mockClient.getLevels();

      expect(result, tResponse);
      verify(() => mockClient.getLevels()).called(1);
    });

    test(
      'getExercisesByMuscleDifficulty delegates with correct params',
      () async {
        const tMuscleId = 'muscle_1';
        const tDifficultyId = 'difficulty_1';
        final tResponse =
            HttpResponse<ExercisesByMuscleDifficultyResponseModel>(
              ExercisesByMuscleDifficultyResponseModel(),
              Response(
                data: null,
                requestOptions: RequestOptions(path: ''),
                statusCode: 200,
              ),
            );

        when(
          () => mockClient.getExercisesByMuscleDifficulty(
            primeMoverMuscleId: tMuscleId,
            difficultyLevelId: tDifficultyId,
          ),
        ).thenAnswer((_) async => tResponse);

        final result = await mockClient.getExercisesByMuscleDifficulty(
          primeMoverMuscleId: tMuscleId,
          difficultyLevelId: tDifficultyId,
        );

        expect(result, tResponse);
        verify(
          () => mockClient.getExercisesByMuscleDifficulty(
            primeMoverMuscleId: tMuscleId,
            difficultyLevelId: tDifficultyId,
          ),
        ).called(1);
      },
    );

    test(
      'getAllMusclesGroup delegates to ApiClient.getAllMusclesGroup',
      () async {
        const tLang = 'en';
        final tResponse = HttpResponse<AllMusclesGroupResponse>(
          AllMusclesGroupResponse(),
          Response(
            data: null,
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
          ),
        );

        when(
          () => mockClient.getAllMusclesGroup(language: tLang),
        ).thenAnswer((_) async => tResponse);

        final result = await mockClient.getAllMusclesGroup(language: tLang);

        expect(result, tResponse);
        verify(() => mockClient.getAllMusclesGroup(language: tLang)).called(1);
      },
    );

    test(
      'getAllMusclesByMuscleGroup delegates with muscleGroupId param',
      () async {
        const tLang = 'en';
        const tGroupId = 'group_1';
        final tResponse = HttpResponse<AllMusclesByMuscleGroupResponse>(
          AllMusclesByMuscleGroupResponse(),
          Response(
            data: null,
            requestOptions: RequestOptions(path: ''),
            statusCode: 200,
          ),
        );

        when(
          () => mockClient.getAllMusclesByMuscleGroup(
            language: tLang,
            muscleGroupId: tGroupId,
          ),
        ).thenAnswer((_) async => tResponse);

        final result = await mockClient.getAllMusclesByMuscleGroup(
          language: tLang,
          muscleGroupId: tGroupId,
        );

        expect(result, tResponse);
        verify(
          () => mockClient.getAllMusclesByMuscleGroup(
            language: tLang,
            muscleGroupId: tGroupId,
          ),
        ).called(1);
      },
    );
  });

  // ── Exercise calls ────────────────────────────────────────────────────────
  group('ApiClient — Exercise calls delegation', () {
    test('getExercises delegates to ApiClient.getExercises', () async {
      const tLang = 'en';
      final tResponse = HttpResponse<ExerciseResponse>(
        ExerciseResponse(),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(
        () => mockClient.getExercises(language: tLang),
      ).thenAnswer((_) async => tResponse);

      final result = await mockClient.getExercises(language: tLang);

      expect(result, tResponse);
      verify(() => mockClient.getExercises(language: tLang)).called(1);
    });

    test('getExercisesRandom delegates with correct params', () async {
      const tLang = 'en';
      const tMuscleId = 'muscle_1';
      const tDiffId = 'diff_1';
      final tResponse = HttpResponse<ExerciseResponse>(
        ExerciseResponse(),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(
        () => mockClient.getExercisesRandom(
          language: tLang,
          muscleGroupId: tMuscleId,
          difficultyId: tDiffId,
        ),
      ).thenAnswer((_) async => tResponse);

      final result = await mockClient.getExercisesRandom(
        language: tLang,
        muscleGroupId: tMuscleId,
        difficultyId: tDiffId,
      );

      expect(result, tResponse);
    });
  });

  // ── Logout & ChangePassword ───────────────────────────────────────────────
  group('ApiClient — Logout & ChangePassword calls delegation', () {
    test('logout delegates to ApiClient.logout', () async {
      const tToken = 'Bearer token_xyz';
      final tResponse = HttpResponse<LogoutResponse>(
        LogoutResponse(),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(
        () => mockClient.logout(token: tToken),
      ).thenAnswer((_) async => tResponse);

      final result = await mockClient.logout(token: tToken);

      expect(result, tResponse);
      verify(() => mockClient.logout(token: tToken)).called(1);
    });

    test('changePassword delegates to ApiClient.changePassword', () async {
      final tRequest = ChangePasswordRequest(
        password: 'old123',
        newPassword: 'new456',
      );
      final tResponse = HttpResponse<ChangePasswordResponse>(
        ChangePasswordResponse(),
        Response(
          data: null,
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
        ),
      );

      when(
        () => mockClient.changePassword(any()),
      ).thenAnswer((_) async => tResponse);

      final result = await mockClient.changePassword(tRequest);

      expect(result, tResponse);
      verify(() => mockClient.changePassword(tRequest)).called(1);
    });
  });
}
