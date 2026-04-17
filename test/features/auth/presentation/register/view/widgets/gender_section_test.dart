import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_fitness_app/features/auth/domain/use_cases/signup_use_case.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/gender_section.dart';
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

  group('GenderSection', () {
    testWidgets('renders titles and gender items correctly', (tester) async {
      await mockNetworkImagesFor(() async {
        await tester.runAsync(() async {
          await tester.pumpWidget(
            buildTestWidget(child: const GenderSection()),
          );
        });
        await tester.pumpAndSettle();

        expect(find.text('tellUsAboutYourself'), findsOneWidget);
        expect(find.text('needToKnowGender'), findsOneWidget);
        expect(find.text('Male'), findsOneWidget);
        expect(find.text('Female'), findsOneWidget);
      });
    });

    testWidgets('Next button is disabled when no gender is selected', (
      tester,
    ) async {
      await mockNetworkImagesFor(() async {
        await tester.runAsync(() async {
          await tester.pumpWidget(
            buildTestWidget(child: const GenderSection()),
          );
        });
        await tester.pumpAndSettle();

        final btn = tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'next'),
        );
        expect(btn.onPressed, isNull);
      });
    });

    testWidgets('tapping Male dispatches SetGender(male)', (tester) async {
      await mockNetworkImagesFor(() async {
        final cubit = SignupCubit(MockSignupUseCase());
        await tester.runAsync(() async {
          await tester.pumpWidget(
            buildTestWidget(child: const GenderSection(), cubit: cubit),
          );
        });
        await tester.pumpAndSettle();

        await tester.tap(find.text('Male'));
        await tester.pump();

        expect(cubit.state.gender, 'male');
      });
    });

    testWidgets('tapping Female dispatches SetGender(female)', (tester) async {
      await mockNetworkImagesFor(() async {
        final cubit = SignupCubit(MockSignupUseCase());
        await tester.runAsync(() async {
          await tester.pumpWidget(
            buildTestWidget(child: const GenderSection(), cubit: cubit),
          );
        });
        await tester.pumpAndSettle();

        await tester.tap(find.text('Female'));
        await tester.pump();

        expect(cubit.state.gender, 'female');
      });
    });
  });
}
