import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:super_fitness_app/features/forget_password/presentation/view_model/forget_password_state.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/screens/forget_password_screen.dart';

import 'forget_password_screens_test.mocks.dart';

@GenerateMocks([ForgetPasswordCubit])
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

  group('ForgetPassword feature screens', () {
    testWidgets('ForgetPasswordScreen renders and validates email', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: ForgetPasswordScreen()));
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verifyNever(mockCubit.onEvent(any));

      await tester.enterText(find.byType(TextFormField), 'invalidemail');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      verifyNever(mockCubit.onEvent(any));

      await tester.enterText(find.byType(TextFormField), 'test@test.com');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(mockCubit.onEvent(any)).called(1);
    });
  });
}
