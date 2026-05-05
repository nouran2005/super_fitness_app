import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/profile/domain/entities/profile_data_model.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_help_data_usecase.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_privacy_policy_data_usecase.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_profile_data_usecase.dart';
import 'package:super_fitness_app/features/profile/domain/use_cases/get_security_data_usecase.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_events.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';

class MockAuthStorage extends Mock implements AuthStorage {}

class MockGetProfileDataUsecase extends Mock implements GetProfileDataUsecase {}

class MockGetHelpDataUsecase extends Mock implements GetHelpDataUsecase {}

class MockGetPrivacyPolicyDataUsecase extends Mock
    implements GetPrivacyPolicyDataUsecase {}

class MockGetSecurityDataUsecase extends Mock
    implements GetSecurityDataUsecase {}

void main() {
  late MockAuthStorage mockAuthStorage;
  late MockGetProfileDataUsecase mockProfileUsecase;
  late MockGetHelpDataUsecase mockHelpUsecase;
  late MockGetPrivacyPolicyDataUsecase mockPrivacyUsecase;
  late MockGetSecurityDataUsecase mockSecurityUsecase;
  late ProfileCubit cubit;

  final tProfileData = ProfileDataModel(
    message: 'Success',
    error: "",
    user: ProfileUserModel(
      id: '123',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      gender: 'male',
      height: 175,
      weight: 70,
      goal: 'loseWeight',
    ),
  );

  setUp(() {
    mockAuthStorage = MockAuthStorage();
    mockProfileUsecase = MockGetProfileDataUsecase();
    mockHelpUsecase = MockGetHelpDataUsecase();
    mockPrivacyUsecase = MockGetPrivacyPolicyDataUsecase();
    mockSecurityUsecase = MockGetSecurityDataUsecase();

    cubit = ProfileCubit(
      mockAuthStorage,
      mockProfileUsecase,
      mockHelpUsecase,
      mockPrivacyUsecase,
      mockSecurityUsecase,
    );
  });

  tearDown(() => cubit.close());

  group('ProfileDataEvent', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, error] when token is null',
      build: () {
        when(() => mockAuthStorage.getToken()).thenAnswer((_) async => null);
        return cubit;
      },
      act: (c) => c.doIntent(ProfileDataEvent()),
      expect: () => [
        isA<ProfileState>().having(
          (s) => s.profileData.status,
          'status',
          Status.loading,
        ),
        isA<ProfileState>()
            .having((s) => s.profileData.status, 'status', Status.error)
            .having((s) => s.profileData.error, 'error', 'Token not found'),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, success] when profile data fetch succeeds',
      build: () {
        when(
          () => mockAuthStorage.getToken(),
        ).thenAnswer((_) async => 'fake_token');
        when(
          () => mockProfileUsecase.call(token: any(named: 'token')),
        ).thenAnswer((_) async => SuccessApiResult(data: tProfileData));
        return cubit;
      },
      act: (c) => c.doIntent(ProfileDataEvent()),
      expect: () => [
        isA<ProfileState>().having(
          (s) => s.profileData.status,
          'status',
          Status.loading,
        ),
        isA<ProfileState>()
            .having((s) => s.profileData.status, 'status', Status.success)
            .having((s) => s.profileData.data, 'data', tProfileData),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, error] when profile data fetch fails',
      build: () {
        when(
          () => mockAuthStorage.getToken(),
        ).thenAnswer((_) async => 'fake_token');
        when(
          () => mockProfileUsecase.call(token: any(named: 'token')),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Fetch failed'));
        return cubit;
      },
      act: (c) => c.doIntent(ProfileDataEvent()),
      expect: () => [
        isA<ProfileState>().having(
          (s) => s.profileData.status,
          'status',
          Status.loading,
        ),
        isA<ProfileState>()
            .having((s) => s.profileData.status, 'status', Status.error)
            .having((s) => s.profileData.error, 'error', 'Fetch failed'),
      ],
    );
  });

  group('ChangeLanguageEvent', () {
    blocTest<ProfileCubit, ProfileState>(
      'toggles language between en and ar',
      build: () => cubit,
      act: (c) {
        c.doIntent(ChangeLanguageEvent());
        c.doIntent(ChangeLanguageEvent());
      },
      expect: () => [
        isA<ProfileState>().having((s) => s.languageCode, 'languageCode', 'ar'),
        isA<ProfileState>().having((s) => s.languageCode, 'languageCode', 'en'),
      ],
    );
  });

  group('HelpDataEvent', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, success] when help data succeeds',
      build: () {
        when(() => mockHelpUsecase.call()).thenAnswer((_) async => 'Help Link');
        return cubit;
      },
      act: (c) => c.doIntent(HelpDataEvent()),
      expect: () => [
        isA<ProfileState>().having(
          (s) => s.help?.status,
          'status',
          Status.loading,
        ),
        isA<ProfileState>()
            .having((s) => s.help?.status, 'status', Status.success)
            .having((s) => s.help?.data, 'data', 'Help Link'),
      ],
    );
  });

  group('PrivacyDataEvent', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, success] when privacy data succeeds',
      build: () {
        when(
          () => mockPrivacyUsecase.call(),
        ).thenAnswer((_) async => 'Privacy Link');
        return cubit;
      },
      act: (c) => c.doIntent(PrivacyDataEvent()),
      expect: () => [
        isA<ProfileState>().having(
          (s) => s.privacy?.status,
          'status',
          Status.loading,
        ),
        isA<ProfileState>()
            .having((s) => s.privacy?.status, 'status', Status.success)
            .having((s) => s.privacy?.data, 'data', 'Privacy Link'),
      ],
    );
  });

  group('SecurityDataEvent', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, success] when security data succeeds',
      build: () {
        when(
          () => mockSecurityUsecase.call(),
        ).thenAnswer((_) async => 'Security Link');
        return cubit;
      },
      act: (c) => c.doIntent(SecurityDataEvent()),
      expect: () => [
        isA<ProfileState>().having(
          (s) => s.security?.status,
          'status',
          Status.loading,
        ),
        isA<ProfileState>()
            .having((s) => s.security?.status, 'status', Status.success)
            .having((s) => s.security?.data, 'data', 'Security Link'),
      ],
    );
  });
}
