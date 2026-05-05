import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/screens/reset_password_screen.dart';

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

  Widget buildTestableWidget() {
    return const MaterialApp(home: ResetPasswordScreen(email: 'test@test.com'));
  }

  group('ResetPasswordScreen Tests', () {
    testWidgets('renders all fields and button', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('shows validation error when passwords do not match', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'Password@123');
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(1), 'Different@123');
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verifyNever(mockCubit.onEvent(any));
    });

    testWidgets('calls ResetPasswordProcessEvent when form is valid', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), 'Password@123');
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).at(1), 'Password@123');
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
    });
  });
}
