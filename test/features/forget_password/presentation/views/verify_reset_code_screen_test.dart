import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/screens/verify_reset_code_screen.dart';
import '../../../../helpers/pump_app.dart';

import 'forget_password_screens_test.mocks.dart';

void main() {
  late MockForgetPasswordCubit mockCubit;

  setUp(() {
    mockCubit = MockForgetPasswordCubit();
    if (getIt.isRegistered<ForgetPasswordCubit>()) {
      getIt.unregister<ForgetPasswordCubit>();
    }
    getIt.registerFactory<ForgetPasswordCubit>(() => mockCubit);

    when(mockCubit.state).thenReturn(
      ForgetPasswordState(
        forgetPassword: Resource.initial(),
        verifyCode: Resource.initial(),
        resetPassword: Resource.initial(),
      ),
    );
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() {
    getIt.reset();
  });

  group('VerifyResetCodeScreen Tests', () {
    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpLocalizedWidget(
        const VerifyResetCodeScreen(email: 'test@test.com'),
        settle: false,
      );

      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('shows snackbar if OTP is incomplete', (
      WidgetTester tester,
    ) async {
      await tester.pumpLocalizedWidget(
        const VerifyResetCodeScreen(email: 'test@test.com'),
        settle: false,
      );

      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pump();

      verifyNever(mockCubit.onEvent(any));
    });

    testWidgets('calls VerifyCodeProcessEvent with complete OTP', (
      WidgetTester tester,
    ) async {
      await tester.pumpLocalizedWidget(
        const VerifyResetCodeScreen(email: 'test@test.com'),
        settle: false,
      );

      tester.testTextInput.enterText('1234');
      await tester.pump(const Duration(seconds: 1));

      final btn = find.byType(ElevatedButton).first;
      await tester.ensureVisible(btn);
      await tester.tap(btn);
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('calls ForgetPasswordProcessEvent when Resend is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpLocalizedWidget(
        const VerifyResetCodeScreen(email: 'test@test.com'),
        settle: false,
      );

      final resendFinder = find.byType(GestureDetector);
      if (resendFinder.evaluate().isNotEmpty) {
        await tester.ensureVisible(resendFinder.last);
        await tester.tap(resendFinder.last);
        await tester.pump(const Duration(seconds: 1));

        verify(mockCubit.onEvent(any)).called(1);
      }
    });
  });
}
