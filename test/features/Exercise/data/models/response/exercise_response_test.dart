import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/Exercise/data/model/response/ExerciseRESponse.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';

void main() {
  group('ExerciseResponse', () {
    final tExerciseJson = {
      '_id': '1',
      'exercise': 'Push Up',
      'difficulty_level': 'Beginner',
      'target_muscle_group': 'Chest',
    };

    final tExerciseResponseJson = {
      'message': 'success',
      'totalExercises': 1,
      'totalPages': 1,
      'currentPage': 1,
      'exercises': [tExerciseJson],
    };

    test('should return a valid model from JSON', () {
      // arrange
      // act
      final result = ExerciseResponse.fromJson(tExerciseResponseJson);

      // assert
      expect(result.message, 'success');
      expect(result.exercises?.length, 1);
      expect(result.exercises?[0].exercise, 'Push Up');
      expect(result.exercises?[0].difficultyLevel, 'Beginner');
    });

    test('should return a JSON map containing proper data', () {
      // arrange
      final model = ExerciseResponse(
        message: 'success',
        totalExercises: 1,
        totalPages: 1,
        currentPage: 1,
        exercises: [
          Exercise(
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
      final exerciseJson = (result['exercises'] as List)[0];
      // Note: _$ExerciseToJson might return the object or a map depending on configuration
      // but usually it's a map. If it's the object, we call toJson() on it.
      expect(exerciseJson.exercise, 'Push Up');
    });

    test('toEntity should map to ExerciseResponseEntity with categories', () {
      // arrange
      final model = ExerciseResponse(
        message: 'success',
        exercises: [
          Exercise(exercise: 'Ex 1', difficultyLevel: 'Beginner'),
          Exercise(exercise: 'Ex 2', difficultyLevel: 'Intermediate'),
          Exercise(exercise: 'Ex 3', difficultyLevel: 'Advanced'),
          Exercise(exercise: 'Ex 4', difficultyLevel: 'Novice'),
        ],
      );

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<ExerciseResponseEntity>());
      expect(entity.exercises?.length, 4);
      expect(entity.categories?.length, 3);

      final beginnerCat = entity.categories?.firstWhere(
        (c) => c.name == 'Beginner',
      );
      final intermediateCat = entity.categories?.firstWhere(
        (c) => c.name == 'Intermediate',
      );
      final advancedCat = entity.categories?.firstWhere(
        (c) => c.name == 'Advanced',
      );

      // Beginner should include 'Beginner' and 'Novice'
      expect(beginnerCat?.exercises.length, 2);
      expect(intermediateCat?.exercises.length, 1);
      expect(advancedCat?.exercises.length, 1);
    });
  });
}
