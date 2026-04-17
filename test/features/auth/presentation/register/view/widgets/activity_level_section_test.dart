import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_model.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_step.dart';
import 'package:super_fitness_app/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/activity_level_section.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';

class MockSignupUseCase extends Mock implements SignupUseCase {}

class TestAssetLoader extends AssetLoader {
  const TestAssetLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    return {
      "physicalActivityLevelQuestion": "Your regular physical activity level?",
      "level1": "level1",
      "level2": "level2",
      "level3": "level3",
      "level4": "level4",
      "level5": "level5",
      "level6": "level6",
    };
  }
}

Widget buildTestWidget({required Widget child, SignupCubit? cubit}) {
  final effectiveCubit = cubit ?? SignupCubit(MockSignupUseCase());

  return EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    assetLoader: const TestAssetLoader(),
    child: BlocProvider<SignupCubit>.value(
      value: effectiveCubit,
      child: MaterialApp(home: Scaffold(body: child)),
    ),
  );
}

SignupCubit seededCubit(SignupStates seed) =>
    SignupCubit(MockSignupUseCase())..emit(seed);

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  group('ActivityLevelSection', () {
    testWidgets('renders title and all activity level options', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(child: const ActivityLevelSection()),
      );
      await tester.pumpAndSettle();

      expect(find.text('physicalActivityLevelQuestion'), findsOneWidget);
      expect(find.text('level1'), findsOneWidget);
      expect(find.text('level2'), findsOneWidget);
      expect(find.text('level3'), findsOneWidget);
      expect(find.text('level4'), findsOneWidget);
      expect(find.text('level5'), findsOneWidget);
    });

    testWidgets('Finish button is disabled when no level is selected', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(child: const ActivityLevelSection()),
      );
      await tester.pumpAndSettle();

      final btn = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'finish'),
      );

      expect(btn.onPressed, isNull);
    });

    testWidgets('tapping an activity level updates cubit state', (
      tester,
    ) async {
      final cubit = SignupCubit(MockSignupUseCase());
      await tester.pumpWidget(
        buildTestWidget(child: const ActivityLevelSection(), cubit: cubit),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('level2'));
      await tester.pump();

      expect(cubit.state.activityLevel, 'level2');
    });

    testWidgets('Finish button is enabled after a level is selected', (
      tester,
    ) async {
      final cubit = seededCubit(
        SignupStates(
          currentStep: SignupStep.activityLevel,
          activityLevel: 'intermediate',
        ),
      );

      await tester.pumpWidget(
        buildTestWidget(child: const ActivityLevelSection(), cubit: cubit),
      );
      await tester.pumpAndSettle();

      final btn = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'finish'),
      );

      expect(btn.onPressed, isNotNull);
    });

    testWidgets(
      'tapping Finish when level is set calls SignupUseCase.execute',
      (tester) async {
        final mockUseCase = MockSignupUseCase();

        final router = GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const ActivityLevelSection(),
            ),
            GoRoute(
              path: '/signin',
              builder: (context, state) =>
                  const Scaffold(body: Text('Login Screen')),
            ),
          ],
        );
        when(
          () => mockUseCase.execute(
            firstName: any(named: 'firstName'),
            lastName: any(named: 'lastName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            rePassword: any(named: 'rePassword'),
            gender: any(named: 'gender'),
            height: any(named: 'height'),
            weight: any(named: 'weight'),
            age: any(named: 'age'),
            goal: any(named: 'goal'),
            activityLevel: any(named: 'activityLevel'),
          ),
        ).thenAnswer((_) async => SuccessApiResult(data: SignupModel(id: '1')));

        final cubit = SignupCubit(mockUseCase)
          ..emit(
            SignupStates(
              currentStep: SignupStep.activityLevel,
              firstName: 'mariam',
              lastName: 'mohamed',
              email: 'mariammmm@gmail.com',
              password: 'Mariam@123',
              gender: 'female',
              age: 25,
              weight: 70,
              height: 175,
              goal: 'loseWeight',
              activityLevel: 'level1',
            ),
          );

        await tester.pumpWidget(
          EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('ar')],
            path: 'assets/translations',
            fallbackLocale: const Locale('en'),
            assetLoader: const TestAssetLoader(),
            child: BlocProvider<SignupCubit>.value(
              value: cubit,
              child: MaterialApp.router(
                routerConfig: router,
                builder: (context, child) {
                  return Scaffold(body: child);
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final finishButtonFinder = find.widgetWithText(
          ElevatedButton,
          'finish',
        );
        await tester.ensureVisible(finishButtonFinder);
        await tester.tap(finishButtonFinder);
        await tester.pumpAndSettle();

        verify(
          () => mockUseCase.execute(
            firstName: any(named: 'firstName'),
            lastName: any(named: 'lastName'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            rePassword: any(named: 'rePassword'),
            gender: any(named: 'gender'),
            height: any(named: 'height'),
            weight: any(named: 'weight'),
            age: any(named: 'age'),
            goal: any(named: 'goal'),
            activityLevel: any(named: 'activityLevel'),
          ),
        ).called(1);

        expect(find.text('Login Screen'), findsOneWidget);
      },
    );
  });
}
