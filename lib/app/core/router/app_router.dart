import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/page/app_sections_view.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/screens/forget_password_screen.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/screens/reset_password_screen.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/screens/verify_reset_code_screen.dart';
import 'package:super_fitness_app/features/signin/presentation/view/pages/signin_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.signIn,
  routes: [
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
  ],
);
