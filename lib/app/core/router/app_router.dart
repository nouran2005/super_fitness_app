import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/features/signin/presentation/view/pages/signin_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.signIn,
  routes: [
    GoRoute(
      path: RouteNames.signIn,

      builder: (context, state) => const SigninPage(),
    ),
  ],
);
