import 'package:easy_localization/easy_localization.dart';
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
    "gainWeight",
    'loseWeight',
    "getFitter",
    'gainMoreFlexibility',
    'learnTheBasics',
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupStates>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignupProgress(),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "whatIsYourGoal".tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'personalizedPlanMsg'.tr(),
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
          ),
        );
      },
    );
  }
}
