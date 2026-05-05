import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_by_category_dto.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_categories_dto.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_details_dto.dart';

abstract class MealsRemoteDataSourceContract {
  Future<ApiResult<MealsCategoriesDto>> getMealsCategories();

  Future<ApiResult<MealsByCategoryDto>> getMealsByCategory(String category);

  Future<ApiResult<MealsDetailsDto>> getMealDetailsById(String mealId);
}
