import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/ui_helper/theme/app_theme.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/screens/goal_edit_screen.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/custom_radio_selection_tile.dart';

import '../../../../../helpers/pump_app.dart';

/// Pumps [GoalEditScreen] inside a [GoRouter] that has a parent route so
/// that `context.pop()` (GoRouterHelper extension) has something to pop
/// back to and does not throw "There is nothing to pop".
Future<void> _pumpGoalScreen(
  WidgetTester tester, {
  String selectedGoal = 'Lose weight',
}) async {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (_, __) => const Scaffold(body: SizedBox.shrink()),
        routes: [
          GoRoute(
            path: 'goal',
            builder: (_, __) => GoalEditScreen(selectedGoal: selectedGoal),
          ),
        ],
      ),
    ],
  );

  await tester.pumpWidget(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      saveLocale: false,
      path: 'unused',
      assetLoader: const TestAssetLoader(),
      child: Builder(
        builder: (context) => MaterialApp.router(
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          theme: AppTheme.lightTheme,
          routerConfig: router,
        ),
      ),
    ),
  );

  // Navigate to goal screen so the router stack has a previous entry.
  router.go('/home/goal');
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
}

void main() {
  group('GoalEditScreen', () {
    testWidgets('renders goal options and handles selection', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      await _pumpGoalScreen(tester, selectedGoal: 'Lose weight');

      // ── renders title ──────────────────────────────────────────────────────
      expect(find.text('WHAT IS YOUR GOAL?'), findsOneWidget);

      // ── renders all 5 goal tiles ──────────────────────────────────────────
      expect(find.byType(CustomRadioSelectionTile), findsNWidgets(5));

      // ── 'Lose weight' is pre-selected ─────────────────────────────────────
      final loseWeightTile = tester.widget<CustomRadioSelectionTile>(
        find.widgetWithText(CustomRadioSelectionTile, 'Lose weight'),
      );
      expect(loseWeightTile.isSelected, isTrue);

      // ── tapping 'Gain weight' selects it ──────────────────────────────────
      await tester.tap(find.text('Gain weight'));
      await tester.pumpAndSettle();

      final gainWeightTile = tester.widget<CustomRadioSelectionTile>(
        find.widgetWithText(CustomRadioSelectionTile, 'Gain weight'),
      );
      expect(gainWeightTile.isSelected, isTrue);

      // ── Done button is present; tapping pops back via GoRouter ─────────────
      expect(find.text('Done'), findsOneWidget);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle(); // should not throw
    });
  });
}
