import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/signup_onboarding_app_bar.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/signup_onboarding_page_body.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';

class SignupOnboardingPage extends StatelessWidget {
  const SignupOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = GoRouterState.of(context).extra as SignupCubit;
    return Scaffold(
      body: BlocProvider.value(
        value: cubit,
        child: AuthBlurryBackground(
          image: Assets.imagesAuthBackground,
          widget: Column(
            children: [
              SignupOnboardingAppBar(),
              Expanded(child: SignupOnboardingPageBody()),
            ],
          ),
        ),
      ),
    );
  }
}
