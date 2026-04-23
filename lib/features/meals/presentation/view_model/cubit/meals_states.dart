import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';

class MealsStates {
  final Resource<MealsCategoriesModel> mealsCategoriesResource;
  final Resource<MealsByCategoryModel> mealsByCategoryResource;
  int selectedIndex;

  MealsStates({
    Resource<MealsCategoriesModel>? mealsCategoriesResource,
    Resource<MealsByCategoryModel>? mealsByCategoryResource,
    this.selectedIndex = 0,
  }) : mealsCategoriesResource = mealsCategoriesResource ?? Resource.initial(),
       mealsByCategoryResource = mealsByCategoryResource ?? Resource.initial();

  MealsStates copyWith({
    Resource<MealsCategoriesModel>? mealsCategoriesResource,
    Resource<MealsByCategoryModel>? mealsByCategoryResource,
    int? selectedIndex,
  }) {
    return MealsStates(
      mealsCategoriesResource:
          mealsCategoriesResource ?? this.mealsCategoriesResource,
      mealsByCategoryResource:
          mealsByCategoryResource ?? this.mealsByCategoryResource,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
