import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/custom_wheel_picker.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/signup_progress.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_intent.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

class HeightSection extends StatelessWidget {
  const HeightSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupStates>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SignupProgress(),

                  const SizedBox(height: 24),
                  Text(
                    'whatIsYourHeight'.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'personalizedPlanMsg'.tr(),
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
                    label: "cm".tr(),
                    items: List.generate(100, (i) => 120 + i),
                    initialValue: state.height ?? 170,
                    onChanged: (val) {
                      cubit.doIntent(SetHeight(val));
                    },
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: state.height == null
                        ? null
                        : () {
                            cubit.doIntent(MoveToNextStep());
                          },
                    child: Text('next'.tr()),
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
