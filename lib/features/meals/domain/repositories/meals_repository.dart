import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';

abstract class MealsRepository {
  Future<ApiResult<MealsCategoriesModel>> getMealsCategories();
}
