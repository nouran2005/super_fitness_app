import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/ui_helper/theme/app_theme.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/screens/activity_edit_screen.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/widgets/custom_radio_selection_tile.dart';

import '../../../../../helpers/pump_app.dart';

/// Pumps [ActivityEditScreen] inside a [GoRouter] that has a real previous
/// route so that `context.pop()` (GoRouterHelper extension) has something
/// to pop back to and does not throw "There is nothing to pop".
Future<void> _pumpActivityScreen(
  WidgetTester tester, {
  String selectedActivity = 'level1',
}) async {
  // A home route + activity route so there's always a back-stack entry.
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (_, __) => const Scaffold(body: SizedBox.shrink()),
        routes: [
          GoRoute(
            path: 'activity',
            builder: (_, __) =>
                ActivityEditScreen(selectedActivity: selectedActivity),
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

  // Navigate to the activity screen so the router has a back-stack entry.
  router.go('/home/activity');
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
}

void main() {
  group('ActivityEditScreen', () {
    testWidgets('renders activity options and handles selection', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      await _pumpActivityScreen(tester, selectedActivity: 'level1');

      // ── renders title ──────────────────────────────────────────────────────
      expect(find.text('WHAT IS YOUR ACTIVITY LEVEL?'), findsOneWidget);

      // ── renders all 5 activity tiles ──────────────────────────────────────
      expect(find.byType(CustomRadioSelectionTile), findsNWidgets(5));

      // ── first option (Rookie / level1) is pre-selected ────────────────────
      final rookieTile = tester.widget<CustomRadioSelectionTile>(
        find.widgetWithText(CustomRadioSelectionTile, 'Rookie'),
      );
      expect(rookieTile.isSelected, isTrue);

      // ── tapping Intermediate selects it ───────────────────────────────────
      await tester.tap(find.text('Intermediate'));
      await tester.pumpAndSettle();

      final intermediateTile = tester.widget<CustomRadioSelectionTile>(
        find.widgetWithText(CustomRadioSelectionTile, 'Intermediate'),
      );
      expect(intermediateTile.isSelected, isTrue);

      // ── Done button is present; tapping pops back via GoRouter ─────────────
      expect(find.text('Done'), findsOneWidget);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle(); // should not throw
    });
  });
}
