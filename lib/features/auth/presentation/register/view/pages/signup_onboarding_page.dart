import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/widgets/auth/auth_blurry_background.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/signup_onboarding_app_bar.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/signup_onboarding_page_body.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';

class SignupOnboardingPage extends StatelessWidget {
  const SignupOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignupCubit>(),
      child: AuthBlurryBackground(
        image: Assets.imagesAuthBackground,
        widget: Column(
          children: const [
            SignupOnboardingAppBar(),
            Expanded(child: SignupOnboardingPageBody()),
          ],
        ),
      ),
    );
  }
}
