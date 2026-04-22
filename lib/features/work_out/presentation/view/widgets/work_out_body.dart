import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscle_group_sections.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscles_grid.dart';

class WorkOutBody extends StatelessWidget {
  const WorkOutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage(Assets.imagesHomeBackground),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.darken,
          ),
        ),
      ),
      child: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'Workouts',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 20),
            MuscleGroupSections(),
            SizedBox(height: 20),
            Expanded(child: MusclesGrid()),
          ],
        ),
      ),
    );
  }
}
