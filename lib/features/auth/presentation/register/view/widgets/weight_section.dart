import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/custom_wheel_picker.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/signup_progress.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_intent.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

class WeightSection extends StatelessWidget {
  const WeightSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupStates>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SignupProgress(),

                  const SizedBox(height: 24),
                  Text(
                    'what is your weight ?',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'this helps us create Your personalized plan',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            GlassBlurContainer(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  HorizontalWheelPicker(
                    label: "Kg",
                    items: List.generate(150, (i) => 30 + i),
                    initialValue: state.weight ?? 70,
                    onChanged: (val) {
                      cubit.doIntent(SetWeight(val));
                    },
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: state.weight == null
                        ? null
                        : () {
                            cubit.doIntent(MoveToNextStep());
                          },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
