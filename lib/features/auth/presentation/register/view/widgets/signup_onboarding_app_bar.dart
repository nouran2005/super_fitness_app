import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_step.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_intent.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

class SignupOnboardingAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SignupOnboardingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupStates>(
      builder: (context, state) {
        return AppBar(
          automaticallyImplyLeading: false,
          leading: state.currentStep == SignupStep.gender
              ? null
              : IconButton(
                  icon: Image.asset(
                    Assets.imagesArrowBack,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () => cubit.doIntent(MoveToPreviousStep()),
                ),
          centerTitle: true,
          title: Image.asset(
            Assets.imagesAppIcon,
            height: 70,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
