import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/pages/signup_onboarding_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/page/app_sections_view.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/pages/register_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.signup,
  routes: [
    GoRoute(
      path: RouteNames.signup,
      builder: (context, state) => RegisterPage(),
    ),

    GoRoute(
      path: RouteNames.completeSignup,
      builder: (context, state) => SignupOnboardingPage(),
    ),

    GoRoute(
      path: RouteNames.home,
      builder: (context, state) => BlocProvider(
        create: (_) => AppSectionsCubit(),
        child: const AppSectionsView(),
      ),
    ),
  ],
);
