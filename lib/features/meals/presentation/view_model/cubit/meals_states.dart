import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';

class MealsStates {
  final Resource<MealsCategoriesModel> mealsCategoriesResource;
  final Resource<MealsByCategoryModel> mealsByCategoryResource;
  final Resource<MealDetailsModel> mealDetailsResource;
  int selectedIndex;

  MealsStates({
    Resource<MealsCategoriesModel>? mealsCategoriesResource,
    Resource<MealsByCategoryModel>? mealsByCategoryResource,
    Resource<MealDetailsModel>? mealDetailsResource,
    this.selectedIndex = 0,
  }) : mealsCategoriesResource = mealsCategoriesResource ?? Resource.initial(),
       mealsByCategoryResource = mealsByCategoryResource ?? Resource.initial(),
       mealDetailsResource = mealDetailsResource ?? Resource.initial();

  MealsStates copyWith({
    Resource<MealsCategoriesModel>? mealsCategoriesResource,
    Resource<MealsByCategoryModel>? mealsByCategoryResource,
    final Resource<MealDetailsModel>? mealDetailsResource,
    int? selectedIndex,
  }) {
    return MealsStates(
      mealsCategoriesResource:
          mealsCategoriesResource ?? this.mealsCategoriesResource,
      mealsByCategoryResource:
          mealsByCategoryResource ?? this.mealsByCategoryResource,
      mealDetailsResource: mealDetailsResource ?? this.mealDetailsResource,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
