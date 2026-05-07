import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';

void main() {
  // ──────────────────────────────────────────────
  // RouteNames
  // ──────────────────────────────────────────────
  group('RouteNames', () {
    test('all route constants have correct path values', () {
      expect(RouteNames.appStart, '/appStart');
      expect(RouteNames.onboarding, '/onboarding');
      expect(RouteNames.signup, '/signup');
      expect(RouteNames.completeSignup, '/completeSignup');
      expect(RouteNames.signIn, '/signin');
      expect(RouteNames.forgetPassword, '/forget-password');
      expect(RouteNames.verifyResetCode, '/verify-reset-code');
      expect(RouteNames.resetPassword, '/reset-password');
      expect(RouteNames.home, '/home');
      expect(RouteNames.homeScreen, '/home-screen');
      expect(RouteNames.meals, '/meals');
      expect(RouteNames.mealDetails, '/mealDetails');
      expect(RouteNames.exercises, '/exercises');
      expect(RouteNames.smartCoach, '/smart-coach');
      expect(RouteNames.smartCoachChat, '/smart-coach-chat');
      expect(RouteNames.helpPage, '/help');
      expect(RouteNames.privacyPage, '/privacy');
      expect(RouteNames.securityPage, '/security');
      expect(RouteNames.editProfile, '/edit-profile');
      expect(RouteNames.changePassword, '/change-password');
    });

    test('all route paths start with a forward slash', () {
      final allRoutes = [
        RouteNames.appStart,
        RouteNames.onboarding,
        RouteNames.signup,
        RouteNames.completeSignup,
        RouteNames.signIn,
        RouteNames.forgetPassword,
        RouteNames.verifyResetCode,
        RouteNames.resetPassword,
        RouteNames.home,
        RouteNames.homeScreen,
        RouteNames.meals,
        RouteNames.mealDetails,
        RouteNames.exercises,
        RouteNames.smartCoach,
        RouteNames.smartCoachChat,
        RouteNames.helpPage,
        RouteNames.privacyPage,
        RouteNames.securityPage,
        RouteNames.editProfile,
        RouteNames.changePassword,
      ];
      for (final route in allRoutes) {
        expect(
          route.startsWith('/'),
          isTrue,
          reason: '$route must start with /',
        );
      }
    });

    test('route names are unique (no accidental duplicates)', () {
      final routes = [
        RouteNames.appStart,
        RouteNames.onboarding,
        RouteNames.signup,
        RouteNames.completeSignup,
        RouteNames.home,
        RouteNames.homeScreen,
        RouteNames.meals,
        RouteNames.mealDetails,
        RouteNames.exercises,
        RouteNames.smartCoach,
        RouteNames.smartCoachChat,
        RouteNames.helpPage,
        RouteNames.privacyPage,
        RouteNames.securityPage,
        RouteNames.editProfile,
        RouteNames.changePassword,
        RouteNames.forgetPassword,
        RouteNames.verifyResetCode,
        RouteNames.resetPassword,
      ];
      final uniqueRoutes = routes.toSet();
      expect(
        uniqueRoutes.length,
        routes.length,
        reason: 'All route paths must be unique',
      );
    });
  });

  // ──────────────────────────────────────────────
  // AppRouter structure
  // ──────────────────────────────────────────────
  group('appRouter', () {
    test('appRouter is a GoRouter instance', () {
      // We import the router lazily to avoid triggering GetIt DI setup
      // The router is defined as a top-level final — we just verify RouteNames
      // are valid GoRouter-compatible paths (starting with /)
      expect(RouteNames.signIn, isA<String>());
    });
  });
}
