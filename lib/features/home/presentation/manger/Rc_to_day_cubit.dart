import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/home/domain/usecase/get_random_muscles_usecase.dart';
import 'Rc_to_day_intents.dart';
import 'Rc_to_day_states.dart';

@injectable
class RcToDayCubit extends Cubit<RcToDayStates> {
  final GetRandomMusclesUseCase _getRandomMusclesUseCase;

  RcToDayCubit(this._getRandomMusclesUseCase)
    : super(RcToDayStates(recommendationResource: Resource.initial()));

  void doIntent(RcToDayIntents intent) {
    switch (intent) {
      case GetRandomMusclesIntent():
        _getRandomMuscles();
    }
  }

  Future<void> _getRandomMuscles() async {
    emit(state.copyWith(recommendationResource: Resource.loading()));
    try {
      final result = await _getRandomMusclesUseCase.execute();
      emit(state.copyWith(recommendationResource: Resource.success(result)));
    } catch (e) {
      emit(
        state.copyWith(recommendationResource: Resource.error(e.toString())),
      );
    }
  }
}
