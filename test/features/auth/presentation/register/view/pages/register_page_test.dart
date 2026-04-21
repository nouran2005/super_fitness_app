import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/pages/register_page.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'register_page_test.mocks.dart';

@GenerateMocks([SignupCubit])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockSignupCubit signupCubit;

  setUp(() async {
    await getIt.reset();
    signupCubit = MockSignupCubit();
    getIt.registerFactory<SignupCubit>(() => signupCubit);
    when(signupCubit.state).thenReturn(SignupStates());
    when(
      signupCubit.stream,
    ).thenAnswer((_) => const Stream<SignupStates>.empty());
  });

  Widget buildTestWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MaterialApp(
        home: Scaffold(
          body: BlocProvider<SignupCubit>(
            create: (_) => signupCubit,
            child: const RegisterPage(),
          ),
        ),
      ),
    );
  }

  group('Register Page UI Test', () {
    testWidgets('should render all main UI elements', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('heyThere'), findsOneWidget);
      expect(find.text(LocaleKeys.createAnAccount), findsOneWidget);
      expect(find.text(LocaleKeys.register), findsNWidgets(2));
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
      final title = tester.widget<Text>(find.text(LocaleKeys.createAnAccount));
      expect(title.style?.fontWeight, FontWeight.w800);
      expect(title.style?.color, AppColors.white);
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('should validate form and not submit when empty', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.textContaining('emailRequired'), findsOneWidget);
      expect(find.textContaining('lastNameRequired'), findsOneWidget);
      expect(find.textContaining('firstNameRequired'), findsOneWidget);
      expect(find.textContaining('passwordRequired'), findsOneWidget);
      expect(find.textContaining('register'), findsNWidgets(2));
    });

    testWidgets('should enter text in fields', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'John');
      await tester.enterText(fields.at(1), 'Doe');
      await tester.enterText(fields.at(2), 'johnemail.com');
      await tester.enterText(fields.at(3), '12345');

      expect(find.text('John'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);
      expect(find.textContaining(LocaleKeys.emailRequired), findsNothing);
      expect(find.textContaining(LocaleKeys.lastNameRequired), findsNothing);

      final button = find.byType(ElevatedButton);
      expect(button, findsOneWidget);

      await tester.tap(button);
      await tester.pump();

      expect(find.text(LocaleKeys.emailInvalid), findsOneWidget);
      expect(find.text(LocaleKeys.passwordLengthInvalid), findsOneWidget);
    });
  });
}
