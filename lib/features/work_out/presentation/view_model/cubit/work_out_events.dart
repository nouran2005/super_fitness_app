sealed class WorkOutEvent {}

class GetAllMusclesGroup extends WorkOutEvent {
  final String language;
  GetAllMusclesGroup({required this.language});
}

class GetMusclesByGroup extends WorkOutEvent {
  final String language;
  final String muscleGroupId;
  GetMusclesByGroup({required this.language, required this.muscleGroupId});
}
