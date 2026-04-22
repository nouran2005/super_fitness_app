sealed class WorkOutEvent {
  const WorkOutEvent();
}

class GetAllMusclesGroup extends WorkOutEvent {
  final String language;
  const GetAllMusclesGroup({required this.language});
}

class GetMusclesByGroup extends WorkOutEvent {
  final String language;
  final String muscleGroupId;
  const GetMusclesByGroup({
    required this.language,
    required this.muscleGroupId,
  });
}
