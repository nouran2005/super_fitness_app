import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/domain/use_cases/get_meal_details_by_id_usecase.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_events.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';

@injectable
class MealsCubit extends Cubit<MealsStates> {
  final GetMealDetailsByIdUsecase _mealDetailsUseCase;
  MealsCubit(this._mealDetailsUseCase) : super(MealsStates());

  void doIntent(MealsIntent intent) {
    if (intent is GetMealDetailsIntent) {
      _getMealDetails(mealId: intent.mealId);
      return;
    }
  }

  Future<void> _getMealDetails({required int mealId}) async {
    emit(state.copyWith(mealDetailsResource: Resource.loading()));
    final result = await _mealDetailsUseCase.call(mealId: mealId);
    switch (result) {
      case SuccessApiResult<MealDetailsModel>():
        emit(
          state.copyWith(mealDetailsResource: Resource.success(result.data)),
        );
      case ErrorApiResult<MealDetailsModel>():
        emit(state.copyWith(mealDetailsResource: Resource.error(result.error)));
    }
  }
}
