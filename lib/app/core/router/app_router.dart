import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/features/app_start/presentation/pages/app_start_page.dart';
import 'package:super_fitness_app/features/onboarding/presentation/pages/onboarding_page.dart';

GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.appStart,
  routes: [
    GoRoute(
      path: RouteNames.appStart,
      builder: (context, state) => const AppStartPage(),
    ),

    GoRoute(
      path: RouteNames.onboarding,
      builder: (context, state) => const OnboardingPage(),

    GoRoute(
      path: RouteNames.home,
      builder: (context, state) => BlocProvider(
        create: (_) => AppSectionsCubit(),
        child: const AppSectionsView(),
      ),
    ),
  ],
);
