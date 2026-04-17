import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_cubit.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_intent.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_states.dart';

import 'app_cubit_test.mocks.dart';

@GenerateMocks([AuthStorage])
void main() {
  late AppCubit cubit;
  late MockAuthStorage mockAuthStorage;

  setUp(() {
    mockAuthStorage = MockAuthStorage();
    cubit = AppCubit(mockAuthStorage);
  });

  tearDown(() {
    cubit.close();
  });

  group('AppCubit Test', () {
    blocTest<AppCubit, AppState>(
      'emits [loading, success(onboarding)] when first time user',
      build: () {
        when(mockAuthStorage.isFirstTimeUser()).thenAnswer((_) async => true);
        when(mockAuthStorage.setNotFirstTime()).thenAnswer((_) async {});
        return cubit;
      },
      act: (cubit) => cubit.doIntent(CheckAuth()),
      expect: () => [
        isA<AppState>().having(
          (s) => s.authResource.status,
          'status',
          Status.loading,
        ),
        isA<AppState>()
            .having((s) => s.authResource.status, 'status', Status.success)
            .having(
              (s) => s.authResource.data,
              'data',
              AppAuthStatus.onboarding,
            ),
      ],
      verify: (_) {
        verify(mockAuthStorage.isFirstTimeUser()).called(1);
        verify(mockAuthStorage.setNotFirstTime()).called(1);
      },
    );

    blocTest<AppCubit, AppState>(
      'emits [loading, success(authenticated)] when not first time and has token',
      build: () {
        when(mockAuthStorage.isFirstTimeUser()).thenAnswer((_) async => false);
        when(mockAuthStorage.getToken()).thenAnswer((_) async => 'some_token');
        return cubit;
      },
      act: (cubit) => cubit.doIntent(CheckAuth()),
      expect: () => [
        isA<AppState>().having(
          (s) => s.authResource.status,
          'status',
          Status.loading,
        ),
        isA<AppState>()
            .having((s) => s.authResource.status, 'status', Status.success)
            .having(
              (s) => s.authResource.data,
              'data',
              AppAuthStatus.authenticated,
            ),
      ],
      verify: (_) {
        verify(mockAuthStorage.isFirstTimeUser()).called(1);
        verify(mockAuthStorage.getToken()).called(1);
      },
    );

    blocTest<AppCubit, AppState>(
      'emits [loading, success(unauthenticated)] when not first time and no token',
      build: () {
        when(mockAuthStorage.isFirstTimeUser()).thenAnswer((_) async => false);
        when(mockAuthStorage.getToken()).thenAnswer((_) async => null);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(CheckAuth()),
      expect: () => [
        isA<AppState>().having(
          (s) => s.authResource.status,
          'status',
          Status.loading,
        ),
        isA<AppState>()
            .having((s) => s.authResource.status, 'status', Status.success)
            .having(
              (s) => s.authResource.data,
              'data',
              AppAuthStatus.unauthenticated,
            ),
      ],
      verify: (_) {
        verify(mockAuthStorage.isFirstTimeUser()).called(1);
        verify(mockAuthStorage.getToken()).called(1);
      },
    );

    blocTest<AppCubit, AppState>(
      'emits [loading, error] when exception happens',
      build: () {
        when(mockAuthStorage.isFirstTimeUser()).thenThrow(Exception('error'));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(CheckAuth()),
      expect: () => [
        isA<AppState>().having(
          (s) => s.authResource.status,
          'status',
          Status.loading,
        ),
        isA<AppState>().having(
          (s) => s.authResource.status,
          'status',
          Status.error,
        ),
      ],
    );
  });
}
