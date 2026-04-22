import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/work_out/domain/use_cases/get_all_muscles_group_use_case.dart';
import 'package:super_fitness_app/features/work_out/domain/use_cases/get_all_muscles_by_muscle_group_use_case.dart';
import 'work_out_events.dart';
import 'work_out_states.dart';

@injectable
class WorkOutCubit extends Cubit<WorkOutStates> {
  final GetAllMusclesGroupUseCase _getAllMusclesGroupUseCase;
  final GetAllMusclesByMuscleGroupUseCase _getAllMusclesByMuscleGroupUseCase;

  WorkOutCubit(
    this._getAllMusclesGroupUseCase,
    this._getAllMusclesByMuscleGroupUseCase,
  ) : super(WorkOutStates());

  void doEvent(WorkOutEvent event) {
    if (event is GetAllMusclesGroup) {
      _getAllMusclesGroup(event.language);
    } else if (event is GetMusclesByGroup) {
      _getMusclesByGroup(event.language, event.muscleGroupId);
    }
  }

  Future<void> _getAllMusclesGroup(String language) async {
    emit(state.copyWith(musclesGroupResource: Resource.loading()));

    final result = await _getAllMusclesGroupUseCase.execute(language: language);

    switch (result) {
      case SuccessApiResult():
        emit(
          state.copyWith(musclesGroupResource: Resource.success(result.data)),
        );
        // Auto-fetch muscles for the first group if it exists
        if (result.data.musclesGroup != null &&
            result.data.musclesGroup!.isNotEmpty) {
          _getMusclesByGroup(
            language,
            result.data.musclesGroup!.first.id ?? '',
          );
        }
        break;

      case ErrorApiResult():
        emit(
          state.copyWith(musclesGroupResource: Resource.error(result.error)),
        );
        break;
    }
  }

  Future<void> _getMusclesByGroup(String language, String muscleGroupId) async {
    emit(
      state.copyWith(
        musclesByGroupResource: Resource.loading(),
        selectedGroupId: muscleGroupId,
      ),
    );

    final result = await _getAllMusclesByMuscleGroupUseCase.execute(
      language: language,
      muscleGroupId: muscleGroupId,
    );

    switch (result) {
      case SuccessApiResult():
        emit(
          state.copyWith(musclesByGroupResource: Resource.success(result.data)),
        );
        break;

      case ErrorApiResult():
        emit(
          state.copyWith(musclesByGroupResource: Resource.error(result.error)),
        );
        break;
    }
  }
}
