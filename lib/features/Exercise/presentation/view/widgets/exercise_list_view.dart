import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';

class ExerciseListView extends StatelessWidget {
  final List<ExerciseEntity> exercises;
  final Function(ExerciseEntity) onExerciseSelected;
  final String Function(String) getYoutubeThumbnail;

  const ExerciseListView({
    super.key,
    required this.exercises,
    required this.onExerciseSelected,
    required this.getYoutubeThumbnail,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: exercises.length,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (context, index) => Divider(
          color: Colors.white.withOpacity(0.1),
          height: 1,
          indent: 10,
          endIndent: 10,
        ),
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          final thumbnail = getYoutubeThumbnail(
            exercise.shortYoutubeDemonstrationLink ?? '',
          );

          return GestureDetector(
            onTap: () => onExerciseSelected(exercise),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      thumbnail,
                      width: size.width * 0.2,
                      height: size.width * 0.2,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: size.width * 0.2,
                        height: size.width * 0.2,
                        color: Colors.white10,
                        child: const Icon(Icons.fitness_center, color: Colors.white24),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.exercise ?? 'Exercise',
                          style: AppStyles.font16Black.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '3 Groups * 15 Times',
                          style: AppStyles.subtitle.copyWith(
                            color: Colors.white60,
                            fontSize: size.width * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: size.width * 0.05,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
