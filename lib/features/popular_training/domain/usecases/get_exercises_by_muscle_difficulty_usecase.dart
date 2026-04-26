import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercises_by_muscle_difficulty_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/repos/popular_training_repo.dart';

@injectable
class GetExercisesByMuscleDifficultyUseCase {
  final PopularTrainingRepo _repo;

  GetExercisesByMuscleDifficultyUseCase(this._repo);

  Future<ApiResult<ExercisesByMuscleDifficultyResponseEntity>> call({
    required String primeMoverMuscleId,
    required String difficultyLevelId,
  }) {
    return _repo.getExercisesByMuscleDifficulty(
      primeMoverMuscleId: primeMoverMuscleId,
      difficultyLevelId: difficultyLevelId,
    );
  }
}
