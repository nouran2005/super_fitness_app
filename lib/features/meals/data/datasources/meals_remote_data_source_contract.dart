import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_categories_dto.dart';

abstract class MealsRemoteDataSourceContract {
  Future<ApiResult<MealsCategoriesDto>> getMealsCategories();
}
