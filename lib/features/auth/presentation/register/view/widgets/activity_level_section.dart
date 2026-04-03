import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/options_selection.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/signup_progress.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_intent.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

class ActivityLevelSection extends StatelessWidget {
  const ActivityLevelSection({super.key});

  static List<String> activityLevels = [
    'rookie',
    'beginner',
    'intermediate',
    'advance',
    'trueBeast',
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
              const SizedBox(height: 20),
              SignupProgress(),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'physicalActivityLevelQuestion'.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: 24),

              GlassBlurContainer(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ...activityLevels.map((level) {
                      final isSelected = state.activityLevel == level;

                      return OptionsSelection(
                        title: level.tr(),
                        isSelected: isSelected,
                        onTap: () {
                          cubit.doIntent(SetActivityLevel(level));
                        },
                      );
                    }),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: state.activityLevel == null
                          ? null
                          : () {
                              cubit.doIntent(PerformSignup());
                            },
                      child: Text('finish'.tr()),
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
