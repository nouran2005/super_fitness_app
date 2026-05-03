import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/signin/domain/entities/signin_entity.dart';
import 'package:super_fitness_app/features/signin/domain/use_cases/signin_use_case.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_cubit.dart';

import 'signin_cubit_test.mocks.dart';

@GenerateMocks([SigninUseCase])
void main() {
  late MockSigninUseCase mockUseCase;
  late SigninCubit cubit;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    mockUseCase = MockSigninUseCase();
    cubit = SigninCubit(signinUseCase: mockUseCase);

    cubit.emailController.text = 'test@mail.com';
    cubit.passwordController.text = '123456';
  });

  setUpAll(() {
    provideDummy<ApiResult<SigninEntity>>(
      SuccessApiResult<SigninEntity>(
        data: SigninEntity(id: '1', firstName: 'Ahmed', lastName: 'Ali'),
      ),
    );
  });

  group('SigninCubit', () {
    blocTest<SigninCubit, dynamic>(
      'calls usecase when signIn success',
      build: () {
        when(mockUseCase.execute(any)).thenAnswer(
          (_) async => SuccessApiResult<SigninEntity>(
            data: SigninEntity(id: '1', firstName: 'Ahmed', lastName: 'Ali'),
          ),
        );

        return cubit;
      },
      act: (cubit) async {
        try {
          await cubit.signIn();
        } catch (_) {}
      },
      verify: (_) {
        verify(mockUseCase.execute(any)).called(1);
      },
    );

    blocTest<SigninCubit, dynamic>(
      'calls usecase when signIn fails',
      build: () {
        when(mockUseCase.execute(any)).thenAnswer(
          (_) async => ErrorApiResult<SigninEntity>(error: 'login failed'),
        );

        return cubit;
      },
      act: (cubit) async {
        try {
          await cubit.signIn();
        } catch (_) {}
      },
      verify: (_) {
        verify(mockUseCase.execute(any)).called(1);
      },
    );
  });
}
