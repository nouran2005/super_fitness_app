import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:super_fitness_app/features/auth/domain/entities/signup_step.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

class SignupProgress extends StatelessWidget {
  const SignupProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<SignupCubit, SignupStates>(
      builder: (context, state) {
        final totalSteps = SignupStep.values.length;
        final currentStepIndex = state.currentStep.index;

        return Center(
          child: CircularPercentIndicator(
            radius: 20,
            lineWidth: 4,
            animation: true,
            percent: (currentStepIndex + 1) / totalSteps,
            center: SizedBox(
              width: 20,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${currentStepIndex + 1}/$totalSteps",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.grey.withAlpha(50),
            progressColor: theme.colorScheme.primary,
          ),
        );
      },
    );
  }
}
