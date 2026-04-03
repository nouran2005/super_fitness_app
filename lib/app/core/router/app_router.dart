import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/pages/signup_onboarding_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.signup,
  routes: [
    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) => SignupOnboardingPage(),
    ),

    GoRoute(
      path: RouteNames.home,
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text("Home"))),
    ),
  ],
);
