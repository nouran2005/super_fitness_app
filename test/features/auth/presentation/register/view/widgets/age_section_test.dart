import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:super_fitness_app/features/auth/domain/entities/signup_step.dart';
import 'package:super_fitness_app/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/age_section.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

class MockSignupUseCase extends Mock implements SignupUseCase {}

class FileAssetLoader extends AssetLoader {
  const FileAssetLoader();
  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    final file = File('$path/${locale.languageCode}.json');
    if (!await file.exists()) return null;
    return json.decode(await file.readAsString()) as Map<String, dynamic>;
  }
}

Widget buildTestWidget({required Widget child, SignupCubit? cubit}) {
  final effectiveCubit = cubit ?? SignupCubit(MockSignupUseCase());
  return EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    assetLoader: const FileAssetLoader(),
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

  group('AgeSection', () {
    testWidgets('renders titles and wheel picker label correctly', (
      tester,
    ) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(buildTestWidget(child: const AgeSection()));
      });
      await tester.pumpAndSettle();

      expect(find.text('howOldAreYou'), findsOneWidget);
      expect(find.text('personalizedPlanMsg'), findsOneWidget);
      expect(find.text('year'), findsOneWidget);
    });

    testWidgets('Next button is disabled when age is null', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(buildTestWidget(child: const AgeSection()));
      });
      await tester.pumpAndSettle();

      final btn = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'next'),
      );
      expect(btn.onPressed, isNull);
    });

    testWidgets('Next button is enabled when age is set', (tester) async {
      final cubit = seededCubit(
        SignupStates(currentStep: SignupStep.age, age: 25),
      );
      await tester.runAsync(() async {
        await tester.pumpWidget(
          buildTestWidget(child: const AgeSection(), cubit: cubit),
        );
      });
      await tester.pumpAndSettle();

      final btn = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'next'),
      );
      expect(btn.onPressed, isNotNull);
    });

    testWidgets('tapping Next when age is set advances to weight step', (
      tester,
    ) async {
      final cubit = seededCubit(
        SignupStates(currentStep: SignupStep.age, age: 25),
      );
      await tester.runAsync(() async {
        await tester.pumpWidget(
          buildTestWidget(child: const AgeSection(), cubit: cubit),
        );
      });
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'next'));
      await tester.tap(find.widgetWithText(ElevatedButton, 'next'));
      await tester.pump();

      expect(cubit.state.currentStep, SignupStep.weight);
    });
  });
}
