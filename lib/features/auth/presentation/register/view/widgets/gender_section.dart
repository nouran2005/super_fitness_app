import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/gender_selection_part.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/signup_progress.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_intent.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

class GenderSection extends StatefulWidget {
  const GenderSection({super.key});

  @override
  State<GenderSection> createState() => _GenderSectionState();
}

class _GenderSectionState extends State<GenderSection> {
  @override
  Widget build(BuildContext context) {
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
                'tellUsAboutYourself'.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'needToKnowGender'.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        GlassBlurContainer(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: const [
              GenderSelectionPart(),
              SizedBox(height: 24),
              _NextButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupStates>(
      builder: (context, state) {
        final cubit = context.read<SignupCubit>();

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.gender == null
                ? null
                : () => cubit.doIntent(MoveToNextStep()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              disabledBackgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withAlpha(100),
              disabledForegroundColor: Theme.of(
                context,
              ).colorScheme.onPrimary.withAlpha(100),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text('next'.tr()),
          ),
        );
      },
    );
  }
}
