import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';

abstract class MealsRepository {
  Future<ApiResult<MealsCategoriesModel>> getMealsCategories();

  Future<ApiResult<MealsByCategoryModel>> getMealsByCategory(String category);

  Future<ApiResult<MealDetailsModel>> getMealDetailsById(int mealId);
}
