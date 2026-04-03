import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_step.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

class SignupOnboardingPageBody extends StatefulWidget {
  const SignupOnboardingPageBody({super.key});
  @override
  State<SignupOnboardingPageBody> createState() =>
      _SignupOnboardingPageBodyState();
}

class _SignupOnboardingPageBodyState extends State<SignupOnboardingPageBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupStates>(
      builder: (context, state) {
        switch (state.currentStep) {
          case SignupStep.gender:
            return const Placeholder();
          case SignupStep.age:
            return const Placeholder();
          case SignupStep.weight:
            return const Placeholder();
          case SignupStep.height:
            return const Placeholder();
          case SignupStep.goal:
            return const Placeholder();
          case SignupStep.activityLevel:
            return const Placeholder();
        }
      },
    );
  }
}
