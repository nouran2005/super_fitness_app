import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';
import 'package:super_fitness_app/features/meals/domain/use_cases/get_meals_categories_usecase.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_intent.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';

@injectable
class MealsCubit extends Cubit<MealsStates> {
  final GetMealsCategoriesUsecase _mealsUseCase;
  MealsCubit(this._mealsUseCase) : super(MealsStates());

  void doIntent(MealsIntent intent) {
    if (intent is GetMealsCategoriesIntent) {
      _getMealsCategories();
      return;
    }
    if (intent is SelectCategoryEvent) {
      _selectCategory(intent.selectedIndex);
      return;
    }
  }

  Future<void> _getMealsCategories() async {
    emit(state.copyWith(mealsCategoriesResource: Resource.loading()));
    final result = await _mealsUseCase.call();
    switch (result) {
      case SuccessApiResult<MealsCategoriesModel>():
        emit(
          state.copyWith(
            mealsCategoriesResource: Resource.success(result.data),
          ),
        );
        break;
      case ErrorApiResult<MealsCategoriesModel>():
        emit(
          state.copyWith(mealsCategoriesResource: Resource.error(result.error)),
        );
        break;
    }
  }

  void _selectCategory(int index) {
    if (state.selectedIndex == index) return;
    emit(state.copyWith(selectedIndex: index));
  }
}
