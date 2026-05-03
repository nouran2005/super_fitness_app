import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:super_fitness_app/features/auth/domain/use_cases/logout_usecase.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart';
import 'package:super_fitness_app/features/auth/presentation/logout/view_model/logout_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/logout/view_model/logout_intent.dart';
import 'package:super_fitness_app/features/auth/presentation/logout/view_model/logout_state.dart';

import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/auth/data/models/response/logout_response.dart';

import 'logout_cubit_test.mocks.dart';

@GenerateMocks([LogoutUsecase, AuthStorage])
void main() {
  late MockLogoutUsecase mockUsecase;
  late MockAuthStorage mockStorage;
  late LogoutCubit cubit;

  setUp(() {
    mockUsecase = MockLogoutUsecase();
    mockStorage = MockAuthStorage();

    cubit = LogoutCubit(mockUsecase, mockStorage);
  });

  setUpAll(() {
    provideDummy<ApiResult<LogoutResponse>>(
      SuccessApiResult<LogoutResponse>(data: LogoutResponse()),
    );
  });
  group('LogoutCubit', () {
    final logoutResponse = LogoutResponse(message: 'success', error: '');

    blocTest<LogoutCubit, LogoutStates>(
      'emits [loading, success] when logout succeeds',
      build: () {
        when(mockStorage.getToken()).thenAnswer((_) async => '123');

        when(mockUsecase.call(token: 'Bearer 123')).thenAnswer(
          (_) async => SuccessApiResult<LogoutResponse>(data: logoutResponse),
        );

        when(mockStorage.clearAll()).thenAnswer((_) async {});

        return cubit;
      },
      act: (cubit) => cubit.doIntent(PerformLogout()),
      expect: () => [
        isA<LogoutStates>(), // loading
        isA<LogoutStates>(), // success
      ],
      verify: (_) {
        verify(mockStorage.getToken()).called(1);
        verify(mockUsecase.call(token: 'Bearer 123')).called(1);
        verify(mockStorage.clearAll()).called(1);
      },
    );

    blocTest<LogoutCubit, LogoutStates>(
      'emits [loading, error] when API fails',
      build: () {
        when(mockStorage.getToken()).thenAnswer((_) async => '123');

        when(mockUsecase.call(token: anyNamed('token'))).thenAnswer(
          (_) async => ErrorApiResult<LogoutResponse>(error: 'Server error'),
        );

        return cubit;
      },
      act: (cubit) => cubit.doIntent(PerformLogout()),
      expect: () => [isA<LogoutStates>(), isA<LogoutStates>()],
      verify: (_) {
        verify(mockUsecase.call(token: 'Bearer 123')).called(1);
      },
    );

    blocTest<LogoutCubit, LogoutStates>(
      'emits [loading, error] when token is missing',
      build: () {
        when(mockStorage.getToken()).thenAnswer((_) async => null);

        return cubit;
      },
      act: (cubit) => cubit.doIntent(PerformLogout()),
      expect: () => [isA<LogoutStates>(), isA<LogoutStates>()],
      verify: (_) {
        verifyNever(mockUsecase.call(token: anyNamed('token')));
      },
    );
  });
}
