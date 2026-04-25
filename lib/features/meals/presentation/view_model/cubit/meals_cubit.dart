import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';
import 'package:super_fitness_app/features/meals/domain/use_cases/get_meals_by_category_usecase.dart';
import 'package:super_fitness_app/features/meals/domain/use_cases/get_meals_categories_usecase.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_intent.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/domain/use_cases/get_meal_details_by_id_usecase.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';

@injectable
class MealsCubit extends Cubit<MealsStates> {
  final GetMealsCategoriesUsecase _mealsUseCase;
  final GetMealsByCategoryUsecase _mealsByCategoryUsecase;
  final GetMealDetailsByIdUsecase _mealDetailsUseCase;

  MealsCubit(
    this._mealsUseCase,
    this._mealsByCategoryUsecase,
    this._mealDetailsUseCase,
  ) : super(MealsStates());

  void doIntent(MealsIntent intent) {
    if (intent is GetMealsCategoriesIntent) {
      _getMealsCategories(initialIndex: intent.initialIndex);
      return;
    }
    if (intent is SelectCategoryEvent) {
      _selectCategory(intent.selectedIndex);
      return;
    }

    if (intent is GetMealDetailsIntent) {
      _getMealDetails(mealId: intent.mealId);
      return;
    }
  }

  Future<void> _getMealsCategories({int? initialIndex}) async {
    emit(state.copyWith(mealsCategoriesResource: Resource.loading()));
    final result = await _mealsUseCase.call();
    switch (result) {
      case SuccessApiResult<MealsCategoriesModel>():
        final meals = result.data.categories ?? [];
        int index = initialIndex ?? 0;
        emit(
          state.copyWith(
            mealsCategoriesResource: Resource.success(result.data),
            selectedIndex: index,
          ),
        );
        if (meals.isNotEmpty) {
          _getMealsByCategory(category: meals[index]?.strCategory ?? '');
        }
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
    final selectedCategory =
        state.mealsCategoriesResource.data?.categories?[index];

    emit(state.copyWith(selectedIndex: index));

    _getMealsByCategory(category: selectedCategory?.strCategory ?? '');
  }

  Future<void> _getMealsByCategory({required String category}) async {
    emit(state.copyWith(mealsByCategoryResource: Resource.loading()));
    final ApiResult<MealsByCategoryModel> result = await _mealsByCategoryUsecase
        .call(category: category);
    switch (result) {
      case SuccessApiResult<MealsByCategoryModel>():
        emit(
          state.copyWith(
            mealsByCategoryResource: Resource.success(result.data),
          ),
        );
      case ErrorApiResult<MealsByCategoryModel>():
        emit(
          state.copyWith(mealsByCategoryResource: Resource.error(result.error)),
        );
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
