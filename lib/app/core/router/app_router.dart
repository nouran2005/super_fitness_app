import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/page/app_sections_view.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/screens/forget_password_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.forgetPassword,
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
  ],
);
