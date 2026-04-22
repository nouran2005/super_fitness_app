import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/api_manger/api_client.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/core/network/safe_api_call.dart';
import 'package:super_fitness_app/features/meals/data/datasources/meals_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_by_category_dto.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_categories_dto.dart';

@Injectable(as: MealsRemoteDataSourceContract)
class MealsRemoteDataSourceImpl extends MealsRemoteDataSourceContract {
  final ApiClient apiClient;
  MealsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ApiResult<MealsCategoriesDto>> getMealsCategories() {
    return safeApiCall(call: () => apiClient.getMealsCategories());
  }

  @override
  Future<ApiResult<MealsByCategoryDto>> getMealsByCategory(String category) {
    return safeApiCall(call: () => apiClient.getMealsByCategory(category));
  }
}
