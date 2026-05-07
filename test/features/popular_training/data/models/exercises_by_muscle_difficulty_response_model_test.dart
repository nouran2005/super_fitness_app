import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/popular_training/data/models/exercises_by_muscle_difficulty_response_model.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercises_by_muscle_difficulty_entity.dart';

void main() {
  group('ExercisesByMuscleDifficultyResponseModel', () {
    final tExerciseJson = {
      '_id': '1',
      'exercise': 'Push Up',
      'difficulty_level': 'Beginner',
      'target_muscle_group': 'Chest',
    };

    final tResponseJson = {
      'message': 'success',
      'totalExercises': 1,
      'totalPages': 1,
      'currentPage': 1,
      'exercises': [tExerciseJson],
    };

    test('should return a valid model from JSON', () {
      // act
      final result = ExercisesByMuscleDifficultyResponseModel.fromJson(
        tResponseJson,
      );

      // assert
      expect(result.message, 'success');
      expect(result.exercises?.length, 1);
      expect(result.exercises?[0].exercise, 'Push Up');
      expect(result.exercises?[0].id, '1');
    });

    test('should return a JSON map containing proper data', () {
      // arrange
      const model = ExercisesByMuscleDifficultyResponseModel(
        message: 'success',
        totalExercises: 1,
        exercises: [
          ExerciseByMuscleDifficultyModel(
            id: '1',
            exercise: 'Push Up',
            difficultyLevel: 'Beginner',
            targetMuscleGroup: 'Chest',
          ),
        ],
      );

      // act
      final result = model.toJson();

      // assert
      expect(result['message'], 'success');
      expect(result['totalExercises'], 1);
      expect(result['exercises'], isA<List>());
    });

    test(
      'toEntity should map to ExercisesByMuscleDifficultyResponseEntity',
      () {
        // arrange
        const model = ExercisesByMuscleDifficultyResponseModel(
          totalExercises: 1,
          exercises: [
            ExerciseByMuscleDifficultyModel(
              id: '1',
              exercise: 'Push Up',
              difficultyLevel: 'Beginner',
            ),
          ],
        );

        // act
        final entity = model.toEntity();

        // assert
        expect(entity, isA<ExercisesByMuscleDifficultyResponseEntity>());
        expect(entity.totalExercises, 1);
        expect(entity.exercises.length, 1);
        expect(entity.exercises[0].exercise, 'Push Up');
        expect(entity.exercises[0].id, '1');
      },
    );
  });
}
