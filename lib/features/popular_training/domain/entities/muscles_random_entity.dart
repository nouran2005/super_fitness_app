class MusclesRandomEntity {
  final List<MuscleEntity> muscles;

  const MusclesRandomEntity({required this.muscles});
}

class MuscleEntity {
  final String id;
  final String name;
  final String image;

  const MuscleEntity({
    required this.id,
    required this.name,
    required this.image,
  });
}
