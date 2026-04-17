import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/page/app_sections_view.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_cubit.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_intent.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_states.dart';
import 'package:super_fitness_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/signin/presentation/view/pages/signin_page.dart';

class AppStartPage extends StatelessWidget {
  const AppStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppCubit>()..doIntent(CheckAuth()),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final authResource = state.authResource;
          if (authResource.isLoading || authResource.isInitial) {
            return const SizedBox.shrink();
          } else if (authResource.isSuccess) {
            switch (authResource.data!) {
              case AppAuthStatus.onboarding:
                return const OnboardingPage();
              case AppAuthStatus.authenticated:
                return BlocProvider(
                  create: (_) => AppSectionsCubit(),
                  child: const AppSectionsView(),
                );
              case AppAuthStatus.unauthenticated:
                return const SigninPage();
            }
          } else {
            return const SigninPage();
          }
        },
      ),
    );
  }
}
