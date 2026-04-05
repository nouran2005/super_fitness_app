import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/forget_password/data/models/request/reset_password_request_model.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/forget_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/reset_password_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/entities/verify_code_entity.dart';
import 'package:super_fitness_app/features/forget_password/domain/usecases/forget_password_usecase.dart';
import 'package:super_fitness_app/features/forget_password/domain/usecases/reset_password_usecase.dart';
import 'package:super_fitness_app/features/forget_password/domain/usecases/verify_code_usecase.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_events.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_state.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([ForgetPasswordUseCase, VerifyCodeUseCase, ResetPasswordUseCase])
void main() {
  provideDummy<ApiResult<ForgetPasswordEntity>>(
    SuccessApiResult<ForgetPasswordEntity>(
      data: const ForgetPasswordEntity(message: '', info: ''),
    ),
  );
  provideDummy<ApiResult<VerifyCodeEntity>>(
    SuccessApiResult<VerifyCodeEntity>(
      data: const VerifyCodeEntity(status: ''),
    ),
  );
  provideDummy<ApiResult<ResetPasswordEntity>>(
    SuccessApiResult<ResetPasswordEntity>(
      data: const ResetPasswordEntity(message: '', token: ''),
    ),
  );

  late ForgetPasswordCubit cubit;
  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late MockVerifyCodeUseCase mockVerifyCodeUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    mockVerifyCodeUseCase = MockVerifyCodeUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();

    cubit = ForgetPasswordCubit(
      mockForgetPasswordUseCase,
      mockVerifyCodeUseCase,
      mockResetPasswordUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('ForgetPasswordCubit', () {
    test('initial state is correct', () {
      expect(cubit.state.forgetPassword.isInitial, isTrue);
      expect(cubit.state.verifyCode.isInitial, isTrue);
      expect(cubit.state.resetPassword.isInitial, isTrue);
    });

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, success] when ForgetPasswordProcessEvent is added and succeeds',
      build: () {
        when(mockForgetPasswordUseCase.call('test@test.com')).thenAnswer(
          (_) async => SuccessApiResult<ForgetPasswordEntity>(
            data: const ForgetPasswordEntity(message: 'Success', info: ''),
          ),
        );
        return cubit;
      },
      act: (cubit) =>
          cubit.onEvent(ForgetPasswordProcessEvent('test@test.com')),
      expect: () => [
        isA<ForgetPasswordState>().having(
          (s) => s.forgetPassword.isLoading,
          'forgetPassword is loading',
          true,
        ),
        isA<ForgetPasswordState>().having(
          (s) => s.forgetPassword.isSuccess,
          'forgetPassword is success',
          true,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, error] when ForgetPasswordProcessEvent is added and fails',
      build: () {
        when(mockForgetPasswordUseCase.call('test@test.com')).thenAnswer(
          (_) async => ErrorApiResult<ForgetPasswordEntity>(error: 'Error 404'),
        );
        return cubit;
      },
      act: (cubit) =>
          cubit.onEvent(ForgetPasswordProcessEvent('test@test.com')),
      expect: () => [
        isA<ForgetPasswordState>().having(
          (s) => s.forgetPassword.isLoading,
          'loading state',
          true,
        ),
        isA<ForgetPasswordState>().having(
          (s) => s.forgetPassword.isError,
          'error state',
          true,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, success] when VerifyCodeProcessEvent is added and succeeds',
      build: () {
        when(mockVerifyCodeUseCase.call('123456')).thenAnswer(
          (_) async => SuccessApiResult<VerifyCodeEntity>(
            data: const VerifyCodeEntity(status: 'Verified'),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(VerifyCodeProcessEvent('123456')),
      expect: () => [
        isA<ForgetPasswordState>().having(
          (s) => s.verifyCode.isLoading,
          'loading state',
          true,
        ),
        isA<ForgetPasswordState>().having(
          (s) => s.verifyCode.isSuccess,
          'success state',
          true,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, error] when VerifyCodeProcessEvent is added and fails',
      build: () {
        when(mockVerifyCodeUseCase.call('123456')).thenAnswer(
          (_) async => ErrorApiResult<VerifyCodeEntity>(error: 'Invalid code'),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(VerifyCodeProcessEvent('123456')),
      expect: () => [
        isA<ForgetPasswordState>().having(
          (s) => s.verifyCode.isLoading,
          'loading state',
          true,
        ),
        isA<ForgetPasswordState>().having(
          (s) => s.verifyCode.isError,
          'error state',
          true,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, success] when ResetPasswordProcessEvent is added and succeeds',
      build: () {
        when(mockResetPasswordUseCase.call(any)).thenAnswer(
          (_) async => SuccessApiResult<ResetPasswordEntity>(
            data: const ResetPasswordEntity(message: 'Success', token: ''),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(
        ResetPasswordProcessEvent(
          ResetPasswordRequestModel(
            email: 'test@test.com',
            newPassword: 'password123',
          ),
        ),
      ),
      expect: () => [
        isA<ForgetPasswordState>().having(
          (s) => s.resetPassword.isLoading,
          'loading state',
          true,
        ),
        isA<ForgetPasswordState>().having(
          (s) => s.resetPassword.isSuccess,
          'success state',
          true,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'emits [loading, error] when ResetPasswordProcessEvent is added and fails',
      build: () {
        when(mockResetPasswordUseCase.call(any)).thenAnswer(
          (_) async => ErrorApiResult<ResetPasswordEntity>(error: 'Error'),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(
        ResetPasswordProcessEvent(
          ResetPasswordRequestModel(
            email: 'test@test.com',
            newPassword: 'password123',
          ),
        ),
      ),
      expect: () => [
        isA<ForgetPasswordState>().having(
          (s) => s.resetPassword.isLoading,
          'loading state',
          true,
        ),
        isA<ForgetPasswordState>().having(
          (s) => s.resetPassword.isError,
          'error state',
          true,
        ),
      ],
    );
  });
}
