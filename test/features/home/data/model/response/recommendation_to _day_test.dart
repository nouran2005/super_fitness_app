import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/home/data/model/response/recommendation_to _day.dart';
import 'package:super_fitness_app/features/home/domain/model/recommendation_entity.dart';

void main() {
  group('RecommendationToDay Model', () {
    final tMuscleJson = {'_id': '1', 'name': 'Bicep', 'image': 'image_url'};

    final tRecommendationJson = {
      'message': 'Success',
      'totalMuscles': 1,
      'muscles': [tMuscleJson],
    };

    test('fromJson should return a valid model', () {
      final result = RecommendationToDay.fromJson(tRecommendationJson);

      expect(result.message, 'Success');
      expect(result.totalMuscles, 1);
      expect(result.muscles?.length, 1);
      expect(result.muscles?[0].name, 'Bicep');
    });

    test('toJson should return a valid JSON map', () {
      final model = RecommendationToDay(
        message: 'Success',
        totalMuscles: 1,
        muscles: [Muscle(id: '1', name: 'Bicep', image: 'image_url')],
      );

      final result = model.toJson();

      expect(result['message'], 'Success');
      expect(result['totalMuscles'], 1);
      expect(result['muscles'][0]['name'], 'Bicep');
    });

    test('toEntity should return a valid RecommendationEntity', () {
      final model = RecommendationToDay(
        message: 'Success',
        totalMuscles: 1,
        muscles: [Muscle(id: '1', name: 'Bicep', image: 'image_url')],
      );

      final result = model.toEntity();

      expect(result, isA<RecommendationEntity>());
      expect(result.message, 'Success');
      expect(result.muscles?.length, 1);
      expect(result.muscles?[0].name, 'Bicep');
    });
  });
}
