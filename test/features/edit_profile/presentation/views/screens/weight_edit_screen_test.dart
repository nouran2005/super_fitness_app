import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/ui_helper/theme/app_theme.dart';
import 'package:super_fitness_app/features/edit_profile/presentation/views/screens/weight_edit_screen.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/custom_wheel_picker.dart';

import '../../../../../helpers/pump_app.dart';

/// Pumps [WeightEditScreen] inside a [GoRouter] that has a parent route so
/// that `context.pop()` (GoRouterHelper extension) has something to pop
/// back to and does not throw "There is nothing to pop".
Future<void> _pumpWeightScreen(
  WidgetTester tester, {
  int initialWeight = 70,
}) async {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (_, __) => const Scaffold(body: SizedBox.shrink()),
        routes: [
          GoRoute(
            path: 'weight',
            builder: (_, __) => WeightEditScreen(initialWeight: initialWeight),
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

  // Navigate to weight screen so the router stack has a previous entry.
  router.go('/home/weight');
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
}

void main() {
  group('WeightEditScreen', () {
    testWidgets('renders weight items and handles selection', (tester) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      await _pumpWeightScreen(tester, initialWeight: 70);

      // ── renders title ──────────────────────────────────────────────────────
      expect(find.text('WHAT IS YOUR WEIGHT?'), findsOneWidget);

      // ── renders the wheel picker ───────────────────────────────────────────
      expect(find.byType(HorizontalWheelPicker), findsOneWidget);

      // ── Done button is present; tapping pops back via GoRouter ─────────────
      expect(find.text('Done'), findsOneWidget);
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle(); // should not throw
    });
  });
}
