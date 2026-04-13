import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_cubit.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_intent.dart';
import 'package:super_fitness_app/features/app_start/presentation/manager/app_states.dart';
import 'package:super_fitness_app/features/onboarding/presentation/pages/home_page.dart';
import 'package:super_fitness_app/features/onboarding/presentation/pages/onboarding_page.dart';

class AppStartPage extends StatelessWidget {
  const AppStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<AppCubit>();
    return BlocProvider(
      create: (_) => cubit,
      child: Builder(
        builder: (context) {
          cubit.doIntent(CheckAuth());
          return BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final authResource = state.authResource;
              if (authResource.isLoading || authResource.isInitial) {
                return const SizedBox.shrink();
              } else if (authResource.isSuccess && authResource.data == true) {
                return const OnboardingPage();
              } else {
                return const HomePage();
              }
            },
          );
        },
      ),
    );
  }
}
