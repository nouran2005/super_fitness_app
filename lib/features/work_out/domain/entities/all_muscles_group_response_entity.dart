import 'package:super_fitness_app/features/work_out/domain/entities/muscle_group_entity.dart';

class AllMusclesGroupResponseEntity {
  final String? message;
  final List<MuscleGroupEntity>? musclesGroup;

  AllMusclesGroupResponseEntity({this.message, this.musclesGroup});
}
