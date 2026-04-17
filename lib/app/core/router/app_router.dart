import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/features/signin/presentation/view/pages/signin_page.dart';
import 'package:super_fitness_app/features/signin/presentation/view_model/cubit/signin_cubit.dart';
import 'package:super_fitness_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/page/app_sections_view.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/app_start/presentation/pages/app_start_page.dart';
import 'package:super_fitness_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/pages/signup_onboarding_page.dart';

GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RouteNames.appStart,
  routes: [
    GoRoute(
      path: RouteNames.appStart,
      builder: (context, state) => const AppStartPage(),
    ),

    GoRoute(
      path: RouteNames.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),

    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) => SignupOnboardingPage(),
    ),

    GoRoute(
      path: RouteNames.home,
      builder: (context, state) => BlocProvider(
        create: (_) => AppSectionsCubit(),
        child: const AppSectionsView(),
      ),
    ),
    GoRoute(
      path: RouteNames.signIn,
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<SigninCubit>(),
        child: const SigninPage(),
      ),
    ),
  ],
);
