import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';
import 'package:super_fitness_app/features/Exercise/domain/usecase/get_exercises_random_use_case.dart';
import 'package:super_fitness_app/features/Exercise/domain/usecase/get_exercises_use_case.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_intent.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_states.dart';

@injectable
class ExerciseCubit extends Cubit<ExerciseStates> {
  final GetExercisesUseCase _getExercisesUseCase;
  final GetExercisesRandomUseCase _getExercisesRandomUseCase;

  ExerciseCubit(this._getExercisesUseCase, this._getExercisesRandomUseCase)
    : super(
        ExerciseStates(
          exerciseResource: Resource.initial(),
          currentExercisesResource: Resource.initial(),
        ),
      );

  void doIntent(ExerciseIntent intent) {
    switch (intent) {
      case GetExercisesIntent():
      case GetCategoriesIntent():
        _getExercises();
        break;
      case GetExercisesRandomIntent():
        _getExercisesRandom(intent.muscleGroupId, intent.difficultyId);
        break;
    }
  }

  Future<void> _getExercises() async {
    emit(state.copyWith(exerciseResource: Resource.loading()));
    final result = await _getExercisesUseCase.execute();
    switch (result) {
      case SuccessApiResult<ExerciseResponseEntity>():
        emit(state.copyWith(exerciseResource: Resource.success(result.data)));
      case ErrorApiResult<ExerciseResponseEntity>():
        emit(state.copyWith(exerciseResource: Resource.error(result.error)));
    }
  }

  Future<void> _getExercisesRandom(String muscleId, String difficultyId) async {
    emit(state.copyWith(currentExercisesResource: Resource.loading()));
    final result = await _getExercisesRandomUseCase.execute(
      muscleGroupId: muscleId,
      difficultyId: difficultyId,
    );
    switch (result) {
      case SuccessApiResult<ExerciseResponseEntity>():
        final allExercises =
            result.data.categories?.expand((c) => c.exercises).toList() ?? [];
        emit(
          state.copyWith(
            currentExercisesResource: Resource.success(allExercises),
          ),
        );
      case ErrorApiResult<ExerciseResponseEntity>():
        emit(
          state.copyWith(
            currentExercisesResource: Resource.error(result.error),
          ),
        );
    }
  }
}
