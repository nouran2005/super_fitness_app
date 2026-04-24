class RecommendationEntity {
  final String? message;
  final int? totalMuscles;
  final List<MuscleEntity>? muscles;

  const RecommendationEntity({this.message, this.totalMuscles, this.muscles});
}

class MuscleEntity {
  final String? id;
  final String? name;
  final String? image;

  const MuscleEntity({this.id, this.name, this.image});
}
