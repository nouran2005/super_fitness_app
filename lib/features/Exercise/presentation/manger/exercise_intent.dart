sealed class ExerciseIntent {
  const ExerciseIntent();
}

class GetExercisesIntent extends ExerciseIntent {
  const GetExercisesIntent();
}

class GetExercisesRandomIntent extends ExerciseIntent {
  final String muscleGroupId;
  final String difficultyId;

  const GetExercisesRandomIntent({
    required this.muscleGroupId,
    required this.difficultyId,
  });
}

class GetCategoriesIntent extends ExerciseIntent {
  const GetCategoriesIntent();
}
