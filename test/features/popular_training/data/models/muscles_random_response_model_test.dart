import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/popular_training/data/models/muscles_random_response_model.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/muscles_random_entity.dart';

void main() {
  group('MusclesRandomResponseModel', () {
    final tMuscleJson = {'_id': '1', 'name': 'Chest', 'image': 'chest_url'};

    final tResponseJson = {
      'message': 'success',
      'totalMuscles': 1,
      'muscles': [tMuscleJson],
    };

    test('should return a valid model from JSON', () {
      // act
      final result = MusclesRandomResponseModel.fromJson(tResponseJson);

      // assert
      expect(result.message, 'success');
      expect(result.muscles?.length, 1);
      expect(result.muscles?[0].name, 'Chest');
      expect(result.muscles?[0].id, '1');
    });

    test('should return a JSON map containing proper data', () {
      // arrange
      const model = MusclesRandomResponseModel(
        message: 'success',
        totalMuscles: 1,
        muscles: [
          RandomMuscleModel(id: '1', name: 'Chest', image: 'chest_url'),
        ],
      );

      // act
      final result = model.toJson();

      // assert
      expect(result['message'], 'success');
      expect(result['muscles'], isA<List>());
    });

    test(
      'toEntity should map to MusclesRandomEntity and filter invalid muscles',
      () {
        // arrange
        const model = MusclesRandomResponseModel(
          muscles: [
            RandomMuscleModel(id: '1', name: 'Chest', image: 'url1'),
            RandomMuscleModel(id: null, name: 'Null ID', image: 'url2'),
            RandomMuscleModel(id: '', name: 'Empty ID', image: 'url3'),
            RandomMuscleModel(id: '2', name: 'Back', image: 'url4'),
          ],
        );

        // act
        final entity = model.toEntity();

        // assert
        expect(entity, isA<MusclesRandomEntity>());
        expect(entity.muscles.length, 2);
        expect(entity.muscles[0].id, '1');
        expect(entity.muscles[1].name, 'Back');
        expect(entity.muscles[1].id, '2');
      },
    );
  });
}
