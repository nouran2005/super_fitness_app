import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_details_dto.dart';

abstract class MealsRemoteDataSourceContract {
  Future<ApiResult<MealsDetailsDto>> getMealDetailsById(String mealId);
}
