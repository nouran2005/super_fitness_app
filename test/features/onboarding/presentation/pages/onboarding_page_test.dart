import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:super_fitness_app/features/onboarding/presentation/widgets/onboarding_button.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildTestableWidget() {
    final router = GoRouter(
      initialLocation: RouteNames.onboarding,
      routes: [
        GoRoute(
          path: RouteNames.onboarding,
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: RouteNames.login,
          builder: (context, state) => const Scaffold(body: Text('Login Page')),
        ),
      ],
    );

    return MaterialApp.router(routerConfig: router);
  }

  group('OnboardingPage Widget Tests', () {
    testWidgets('should display first page correctly', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();
      expect(find.text(LocaleKeys.titleOnboarding1), findsOneWidget);
      expect(find.text(LocaleKeys.descriptionOnboarding), findsOneWidget);
      expect(
        find.image(AssetImage(Assets.imagesOnboardingBackground)),
        findsOneWidget,
      );
      expect(find.text(LocaleKeys.skip), findsOneWidget);
      expect(find.text(LocaleKeys.next), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(SizedBox), findsAtLeast(1));
    });

    testWidgets('navigate to second page', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      final buttonFinder = find.byType(OnboardingButton);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.text(LocaleKeys.titleOnboarding1), findsNothing);
      expect(find.text(LocaleKeys.titleOnboarding2), findsOneWidget);
      expect(
        find.byElementPredicate((element) => element.widget is ElevatedButton),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel(LocaleKeys.back), findsOneWidget);
      expect(find.byType(Row), findsNWidgets(2));
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('navigate to third page', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      final nextButton = find.text(LocaleKeys.next);

      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      expect(find.text(LocaleKeys.titleOnboarding2), findsNothing);
      expect(find.text(LocaleKeys.titleOnboarding3), findsOneWidget);
      expect(find.text(LocaleKeys.doIt), findsOneWidget);
    });

    testWidgets('should navigate to login when skip is pressed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      final skipButton = find.text(LocaleKeys.skip);
      await tester.tap(skipButton);
      await tester.pumpAndSettle();

      expect(find.byWidget(OnboardingPage()), findsNothing);
      expect(find.text('Login Page'), findsOneWidget);
    });

    testWidgets('should navigate to login on last page', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      final nextButton = find.text(LocaleKeys.next);
      await tester.tap(nextButton);
      await tester.pumpAndSettle();
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      final doneButton = find.text(LocaleKeys.doIt);
      await tester.tap(doneButton);
      await tester.pumpAndSettle();

      expect(find.text('Login Page'), findsOneWidget);
    });
  });
}
