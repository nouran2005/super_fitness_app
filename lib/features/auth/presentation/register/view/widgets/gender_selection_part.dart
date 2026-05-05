import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/gender_item.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_cubit.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view_model/signup_states.dart';

class GenderSelectionPart extends StatelessWidget {
  const GenderSelectionPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupStates>(
      builder: (context, state) {
        return Column(
          children: [
            GenderItem(title: 'Male', isSelected: state.gender == 'male'),
            const SizedBox(height: 24),
            GenderItem(title: 'Female', isSelected: state.gender == 'female'),
          ],
        );
      },
    );
  }
}
