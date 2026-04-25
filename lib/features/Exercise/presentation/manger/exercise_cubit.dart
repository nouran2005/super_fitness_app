import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';
import 'package:super_fitness_app/features/Exercise/domain/usecase/get_exercises_use_case.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_intent.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_states.dart';

@injectable
class ExerciseCubit extends Cubit<ExerciseStates> {
  final GetExercisesUseCase _getExercisesUseCase;

  ExerciseCubit(this._getExercisesUseCase)
    : super(
        ExerciseStates(
          exerciseResource: Resource.initial(),
          beginnerResource: Resource.initial(),
          intermediateResource: Resource.initial(),
          advancedResource: Resource.initial(),
        ),
      );

  void doIntent(ExerciseIntent intent) {
    switch (intent) {
      case GetExercisesIntent():
      case GetCategoriesIntent():
        _getExercises();
        break;
      case GetBeginnerExercisesIntent():
        _getBeginnerExercises();
        break;
      case GetIntermediateExercisesIntent():
        _getIntermediateExercises();
        break;
      case GetAdvancedExercisesIntent():
        _getAdvancedExercises();
        break;
    }
  }

  Future<void> _getExercises() async {
    emit(
      state.copyWith(
        exerciseResource: Resource.loading(),
        beginnerResource: Resource.loading(),
        intermediateResource: Resource.loading(),
        advancedResource: Resource.loading(),
      ),
    );
    final result = await _getExercisesUseCase.execute();
    switch (result) {
      case SuccessApiResult<ExerciseResponseEntity>():
        final data = result.data;
        final beginner =
            data.categories?.firstWhere((c) => c.name == 'Beginner').exercises ??
            [];
        final intermediate =
            data.categories
                ?.firstWhere((c) => c.name == 'Intermediate')
                .exercises ??
            [];
        final advanced =
            data.categories?.firstWhere((c) => c.name == 'Advanced').exercises ??
            [];

        emit(
          state.copyWith(
            exerciseResource: Resource.success(data),
            beginnerResource: Resource.success(beginner),
            intermediateResource: Resource.success(intermediate),
            advancedResource: Resource.success(advanced),
          ),
        );
      case ErrorApiResult<ExerciseResponseEntity>():
        emit(
          state.copyWith(
            exerciseResource: Resource.error(result.error),
            beginnerResource: Resource.error(result.error),
            intermediateResource: Resource.error(result.error),
            advancedResource: Resource.error(result.error),
          ),
        );
    }
  }

  Future<void> _getBeginnerExercises() async {
    if (state.exerciseResource.isSuccess) {
      final beginner =
          state.exerciseResource.data?.categories
              ?.firstWhere((c) => c.name == 'Beginner')
              .exercises ??
          [];
      emit(state.copyWith(beginnerResource: Resource.success(beginner)));
    } else {
      await _getExercises();
    }
  }

  Future<void> _getIntermediateExercises() async {
    if (state.exerciseResource.isSuccess) {
      final intermediate =
          state.exerciseResource.data?.categories
              ?.firstWhere((c) => c.name == 'Intermediate')
              .exercises ??
          [];
      emit(
        state.copyWith(intermediateResource: Resource.success(intermediate)),
      );
    } else {
      await _getExercises();
    }
  }

  Future<void> _getAdvancedExercises() async {
    if (state.exerciseResource.isSuccess) {
      final advanced =
          state.exerciseResource.data?.categories
              ?.firstWhere((c) => c.name == 'Advanced')
              .exercises ??
          [];
      emit(state.copyWith(advancedResource: Resource.success(advanced)));
    } else {
      await _getExercises();
    }
  }
}
