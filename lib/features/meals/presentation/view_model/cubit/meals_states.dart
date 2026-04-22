import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';

class MealsStates {
  final Resource<MealsCategoriesModel> mealsCategoriesResource;
  final int selectedIndex;
  final List<CategoriesModel> categoriesList;

  MealsStates({
    Resource<MealsCategoriesModel>? mealsCategoriesResource,
    this.selectedIndex = 0,
    this.categoriesList = const [],
  }) : mealsCategoriesResource = mealsCategoriesResource ?? Resource.initial();

  MealsStates copyWith({
    Resource<MealsCategoriesModel>? mealsCategoriesResource,
    int? selectedIndex,
    List<CategoriesModel>? categoriesList,
  }) {
    return MealsStates(
      mealsCategoriesResource:
          mealsCategoriesResource ?? this.mealsCategoriesResource,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      categoriesList: categoriesList ?? this.categoriesList,
    );
  }
}
