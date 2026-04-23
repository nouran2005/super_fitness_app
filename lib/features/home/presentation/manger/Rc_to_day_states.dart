import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/home/domain/model/recommendation_entity.dart';

class RcToDayStates {
  final Resource<RecommendationEntity> recommendationResource;

  RcToDayStates({required this.recommendationResource});

  RcToDayStates copyWith({Resource<RecommendationEntity>? recommendationResource}) {
    return RcToDayStates(
      recommendationResource: recommendationResource ?? this.recommendationResource,
    );
  }
}
