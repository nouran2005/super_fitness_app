import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/exercises_by_muscle_difficulty_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/muscles_random_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/popular_training_entity.dart';
import 'package:super_fitness_app/features/popular_training/domain/usecases/get_exercises_by_muscle_difficulty_usecase.dart';
import 'package:super_fitness_app/features/popular_training/domain/usecases/get_levels_usecase.dart';
import 'package:super_fitness_app/features/popular_training/domain/usecases/get_random_muscles_usecase.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_events.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_state.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

typedef _Combo = ({
  String muscleId,
  String levelId,
  String muscleImage,
  String muscleName,
});

@injectable
class PopularTrainingCubit extends Cubit<PopularTrainingState> {
  PopularTrainingCubit(
    this._getRandomMusclesUseCase,
    this._getLevelsUseCase,
    this._getExercisesUseCase,
  ) : super(PopularTrainingState(popularExercises: Resource.initial()));

  final GetRandomMusclesUseCase _getRandomMusclesUseCase;
  final GetLevelsUseCase _getLevelsUseCase;
  final GetExercisesByMuscleDifficultyUseCase _getExercisesUseCase;

  static const int _targetExercisesSize = 15;
  static const int _batchSize = 22;

  final _random = Random();

  void onEvent(PopularTrainingEvents event) {
    if (event is LoadPopularTrainingExercisesEvent) _loadExercises();
  }

  Future<void> _loadExercises() async {
    emit(state.copyWith(popularExercises: Resource.loading()));

    final [musclesResult, levelsResult] = await Future.wait([
      _getRandomMusclesUseCase.getRandomMuscles(),
      _getLevelsUseCase.getLevels(),
    ]);

    if (musclesResult case ErrorApiResult(:final error)) {
      emit(state.copyWith(popularExercises: Resource.error(error)));
      return;
    }
    if (levelsResult case ErrorApiResult(:final error)) {
      emit(state.copyWith(popularExercises: Resource.error(error)));
      return;
    }

    final muscles = (musclesResult as SuccessApiResult).data.muscles;
    final levelIds = (levelsResult as SuccessApiResult).data.ids;

    if (muscles.isEmpty || levelIds.isEmpty) {
      emit(
        state.copyWith(
          popularExercises: Resource.error(
            LocaleKeys.no_muscles_or_levels_available.tr(),
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        popularExercises: Resource.success(
          await _buildExercises(muscles, levelIds),
        ),
      ),
    );
  }

  Future<List<PopularTrainingEntity>> _buildExercises(
    List<MuscleEntity> muscles,
    List<String> levelIds,
  ) async {
    final result = <PopularTrainingEntity>[];

    while (result.length < _targetExercisesSize) {
      final deficit = _targetExercisesSize - result.length;
      final combos = _generateCombinations(
        muscles: muscles,
        levelIds: levelIds,
        count: _batchSize + deficit,
      );

      final responses = await Future.wait(
        combos.map(
          (c) => _getExercisesUseCase(
            primeMoverMuscleId: c.muscleId,
            difficultyLevelId: c.levelId,
          ),
        ),
      );

      for (var i = 0; i < responses.length; i++) {
        if (result.length >= _targetExercisesSize) break;

        final response = responses[i];
        if (response
            is! SuccessApiResult<ExercisesByMuscleDifficultyResponseEntity>) {
          continue;
        }

        final exercises = response.data.exercises;
        if (exercises.isEmpty) continue;

        final combo = combos[i];
        result.add(
          PopularTrainingEntity(
            exercise: exercises[_random.nextInt(exercises.length)],
            muscleImage: combo.muscleImage,
            muscleName: combo.muscleName,
            totalExercises: response.data.totalExercises,
          ),
        );
      }
    }

    return result;
  }

  List<_Combo> _generateCombinations({
    required List<MuscleEntity> muscles,
    required List<String> levelIds,
    required int count,
  }) => List.generate(count, (_) {
    final muscle = muscles[_random.nextInt(muscles.length)];
    return (
      muscleId: muscle.id,
      levelId: levelIds[_random.nextInt(levelIds.length)],
      muscleImage: muscle.image,
      muscleName: muscle.name,
    );
  });
}
