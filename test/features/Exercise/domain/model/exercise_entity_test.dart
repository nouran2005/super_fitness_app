import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';

void main() {
  group('ExerciseEntity', () {
    test('supports value equality', () {
      expect(
        const ExerciseEntity(id: '1', exercise: 'Push Up'),
        equals(const ExerciseEntity(id: '1', exercise: 'Push Up')),
      );
    });

    test('different values are not equal', () {
      expect(
        const ExerciseEntity(id: '1', exercise: 'Push Up'),
        isNot(equals(const ExerciseEntity(id: '2', exercise: 'Push Up'))),
      );
    });
  });

  group('ExerciseCategoryEntity', () {
    test('supports value equality', () {
      const exercise = ExerciseEntity(id: '1', exercise: 'Push Up');
      expect(
        const ExerciseCategoryEntity(name: 'Beginner', exercises: [exercise]),
        equals(
          const ExerciseCategoryEntity(name: 'Beginner', exercises: [exercise]),
        ),
      );
    });
  });

  group('ExerciseResponseEntity', () {
    test('supports value equality', () {
      expect(
        const ExerciseResponseEntity(message: 'success', totalExercises: 1),
        equals(
          const ExerciseResponseEntity(message: 'success', totalExercises: 1),
        ),
      );
    });
  });
}
