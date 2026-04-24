import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/popular_training/domain/entities/popular_training_entity.dart';

class PopularTrainingState {
  final Resource<List<PopularTrainingEntity>> popularExercises;

  const PopularTrainingState({required this.popularExercises});

  PopularTrainingState copyWith({
    Resource<List<PopularTrainingEntity>>? popularExercises,
  }) {
    return PopularTrainingState(
      popularExercises: popularExercises ?? this.popularExercises,
    );
  }
}
