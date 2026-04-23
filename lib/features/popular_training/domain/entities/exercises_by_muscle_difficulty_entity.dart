class ExercisesByMuscleDifficultyResponseEntity {
  final List<ExerciseEntity> exercises;

  const ExercisesByMuscleDifficultyResponseEntity({required this.exercises});
}

class ExerciseEntity {
  final String id;
  final String exercise;
  final String difficultyLevel;
  final String shortYoutubeDemonstration;

  const ExerciseEntity({
    required this.id,
    required this.exercise,
    required this.difficultyLevel,
    required this.shortYoutubeDemonstration,
  });
}
