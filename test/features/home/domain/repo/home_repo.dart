import 'package:super_fitness_app/features/home/domain/model/recommendation_entity.dart';

abstract class HomeRepo {
  Future<RecommendationEntity> getRandomMuscles();
}
