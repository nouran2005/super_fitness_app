import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/options_selection.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/signup_progress.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_intent.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

class GoalSection extends StatelessWidget {
  const GoalSection({super.key});

  static const goals = [
    "Gain Weight",
    'Lose Weight',
    "Get Fitter",
    'Gain More Flexibility',
    'Learn the Basics',
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupStates>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            SignupProgress(),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'What is your goal?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'this helps us create Your personalized plan',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            const SizedBox(height: 24),

            GlassBlurContainer(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ...goals.map((goal) {
                    final isSelected = state.goal == goal;
                    return OptionsSelection(
                      title: goal,
                      isSelected: isSelected,
                      onTap: () {
                        cubit.doIntent(SetGoal(goal));
                      },
                    );
                  }),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: state.goal == null
                        ? null
                        : () {
                            cubit.doIntent(MoveToNextStep());
                          },
                    child: const Text('Next'),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
