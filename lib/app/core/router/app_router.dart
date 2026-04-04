import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/features/auth/register/presentation/pages/register_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.register,
  routes: [
    GoRoute(
      path: RouteNames.register,
      builder: (context, state) => RegisterPage(),
    ),
  ],
);
