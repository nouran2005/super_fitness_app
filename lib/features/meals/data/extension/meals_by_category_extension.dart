import 'package:super_fitness_app/features/meals/data/models/response/meals_by_category_dto.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';

extension MealsByCategoryExtension on MealsByCategoryDto {
  MealsByCategoryModel toMealsByCategoryModel() {
    return MealsByCategoryModel(
      meals: meals?.map((e) => e?.toMealsModel()).toList(),
    );
  }
}

extension MealsExtension on MealsDto {
  MealsModel toMealsModel() {
    return MealsModel(
      strMeal: strMeal,
      strMealThumb: strMealThumb,
      idMeal: idMeal,
    );
  }
}
