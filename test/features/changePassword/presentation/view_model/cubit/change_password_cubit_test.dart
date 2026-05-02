import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/auth_storage/auth_storage.dart'; 
import 'package:super_fitness_app/app/core/network/api_result.dart'; 
import 'package:super_fitness_app/features/changePassword/data/model/response/change_password_response.dart';
import 'package:super_fitness_app/features/changePassword/domain/use_cases/change_password_usecase.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view_model/cubit/change_password_cubit.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view_model/cubit/change_password_intent.dart';
import 'package:super_fitness_app/features/changePassword/presentation/view_model/cubit/change_password_state.dart';

import 'change_password_cubit_test.mocks.dart';

@GenerateMocks([ChangePasswordUseCase, AuthStorage])
void main() {
  provideDummy<ApiResult<ChangePasswordResponse>>(
    SuccessApiResult(data: ChangePasswordResponse()),
  );

  late MockChangePasswordUseCase mockUseCase;
  late MockAuthStorage mockAuthStorage;

  setUp(() {
    mockUseCase = MockChangePasswordUseCase();
    mockAuthStorage = MockAuthStorage();
  });

  group('ChangePasswordCubit Tests', () {
    test('initial state should be Resource.initial()', () {
      final cubit = ChangePasswordCubit(mockUseCase, mockAuthStorage);
      expect(cubit.state.changePasswordResource.isInitial, true);
      cubit.close();
    });

    blocTest<ChangePasswordCubit, ChangePasswordStates>(
      'emits [loading, success] when password change is successful',
      build: () {
        final cubit = ChangePasswordCubit(mockUseCase, mockAuthStorage);
        final response =
            ChangePasswordResponse(message: "Success", token: "new_token");
        when(mockUseCase.execute(any)).thenAnswer(
          (_) async => SuccessApiResult(data: response),
        );
        when(mockAuthStorage.saveToken(any)).thenAnswer((_) async => {});

        cubit.oldPasswordController.text = "old_pass";
        cubit.newPasswordController.text = "new_pass";
        return cubit;
      },
      act: (cubit) => cubit.doIntent(ChangePasswordSubmitIntent()),
      expect: () => [
        isA<ChangePasswordStates>().having(
            (s) => s.changePasswordResource.isLoading, 'loading', true),
        isA<ChangePasswordStates>().having(
            (s) => s.changePasswordResource.isSuccess, 'success', true),
      ],
      verify: (_) {
        verify(mockUseCase.execute(any)).called(1);
        verify(mockAuthStorage.saveToken("new_token")).called(1);
      },
    );

    blocTest<ChangePasswordCubit, ChangePasswordStates>(
      'emits [loading, error] when password change fails',
      build: () {
        final cubit = ChangePasswordCubit(mockUseCase, mockAuthStorage);
        when(mockUseCase.execute(any)).thenAnswer(
          (_) async => ErrorApiResult(error: "Invalid password"),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(ChangePasswordSubmitIntent()),
      expect: () => [
        isA<ChangePasswordStates>().having((s) => s.changePasswordResource.isLoading, 'loading', true),
        isA<ChangePasswordStates>().having((s) => s.changePasswordResource.isError, 'error', true),
      ],
    );
  });
}
