import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/data/datasources/meals_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/meals/data/extension/meal_details_dto_extension.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_details_dto.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/domain/repositories/meals_repository.dart';

@Injectable(as: MealsRepository)
class MealsRepositoryImpl extends MealsRepository {
  final MealsRemoteDataSourceContract remoteDataSource;
  MealsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<MealDetailsModel>> getMealDetailsById(String mealId) async {
    final response = await remoteDataSource.getMealDetailsById(mealId);

    switch (response) {
      case SuccessApiResult<MealsDetailsDto>():
        MealsDetailsDto dto = response.data;
        MealDetailsModel meal = dto.toMealDetailsModel();
        return SuccessApiResult<MealDetailsModel>(data: meal);

      case ErrorApiResult<MealsDetailsDto>():
        return ErrorApiResult<MealDetailsModel>(
          error: response.error.toString(),
        );
    }
  }
}
