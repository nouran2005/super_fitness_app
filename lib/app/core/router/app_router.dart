import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/pages/register_page.dart';
import 'package:super_fitness_app/features/signin/presentation/view/pages/signin_page.dart';
import 'package:super_fitness_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/page/app_sections_view.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/app_start/presentation/pages/app_start_page.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/screens/forget_password_screen.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/screens/reset_password_screen.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/screens/verify_reset_code_screen.dart';
import 'package:super_fitness_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/pages/signup_onboarding_page.dart';
import 'package:super_fitness_app/features/home/presentation/pages/HomeScreen.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RouteNames.home,
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
    GoRoute(
      path: RouteNames.forgetPassword,
      builder: (context, state) => ForgetPasswordScreen(),
    ),
    GoRoute(
      path: RouteNames.verifyResetCode,
      builder: (context, state) =>
          VerifyResetCodeScreen(email: state.extra as String),
    ),
    GoRoute(
      path: RouteNames.resetPassword,
      builder: (context, state) =>
          ResetPasswordScreen(email: state.extra as String),
    ),
    GoRoute(
      path: RouteNames.signIn,
      builder: (context, state) => const SigninPage(),
    ),

    GoRoute(
      path: RouteNames.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
