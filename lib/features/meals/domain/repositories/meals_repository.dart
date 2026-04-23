import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';

abstract class MealsRepository {
  Future<ApiResult<MealDetailsModel>> getMealDetailsById(String mealId);
}
