import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/popular_training/data/models/levels_response_model.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/levels_entity.dart';

void main() {
  group('LevelsResponseModel', () {
    final tLevelJson = {'_id': '1', 'name': 'Beginner'};

    final tResponseJson = {
      'message': 'success',
      'levels': [tLevelJson],
    };

    test('should return a valid model from JSON', () {
      // act
      final result = LevelsResponseModel.fromJson(tResponseJson);

      // assert
      expect(result.message, 'success');
      expect(result.levels?.length, 1);
      expect(result.levels?[0].name, 'Beginner');
      expect(result.levels?[0].id, '1');
    });

    test('should return a JSON map containing proper data', () {
      // arrange
      const model = LevelsResponseModel(
        message: 'success',
        levels: [LevelModel(id: '1', name: 'Beginner')],
      );

      // act
      final result = model.toJson();

      // assert
      expect(result['message'], 'success');
      expect(result['levels'], isA<List>());
    });

    test('toEntity should map to LevelsEntity and filter empty IDs', () {
      // arrange
      const model = LevelsResponseModel(
        levels: [
          LevelModel(id: '1', name: 'Beginner'),
          LevelModel(id: '', name: 'Empty'),
          LevelModel(id: '2', name: 'Intermediate'),
        ],
      );

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<LevelsEntity>());
      expect(entity.ids.length, 2);
      expect(entity.ids, containsAll(['1', '2']));
    });
  });
}
