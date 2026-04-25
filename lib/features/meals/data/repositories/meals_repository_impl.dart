import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/data/datasources/meals_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/meals/data/extension/meals_by_category_extension.dart';
import 'package:super_fitness_app/features/meals/data/extension/meals_categories_extension.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_by_category_dto.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_categories_dto.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';
import 'package:super_fitness_app/features/meals/data/extension/meal_details_dto_extension.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_details_dto.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/domain/repositories/meals_repository.dart';

@Injectable(as: MealsRepository)
class MealsRepositoryImpl extends MealsRepository {
  final MealsRemoteDataSourceContract remoteDataSource;
  MealsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<MealsCategoriesModel>> getMealsCategories() async {
    final categoriesResponse = await remoteDataSource.getMealsCategories();

    switch (categoriesResponse) {
      case SuccessApiResult<MealsCategoriesDto>():
        MealsCategoriesDto dto = categoriesResponse.data;
        MealsCategoriesModel category = dto.toMealsCategoriesModel();
        return SuccessApiResult<MealsCategoriesModel>(data: category);

      case ErrorApiResult<MealsCategoriesDto>():
        return ErrorApiResult<MealsCategoriesModel>(
          error: categoriesResponse.error.toString(),
        );
    }
  }

  @override
  Future<ApiResult<MealsByCategoryModel>> getMealsByCategory(
    String category,
  ) async {
    final mealsByCategoryResponse = await remoteDataSource.getMealsByCategory(
      category,
    );

    switch (mealsByCategoryResponse) {
      case SuccessApiResult<MealsByCategoryDto>():
        MealsByCategoryDto dto = mealsByCategoryResponse.data;
        MealsByCategoryModel model = dto.toMealsByCategoryModel();
        return SuccessApiResult<MealsByCategoryModel>(data: model);

      case ErrorApiResult<MealsByCategoryDto>():
        return ErrorApiResult<MealsByCategoryModel>(
          error: mealsByCategoryResponse.error.toString(),
        );
    }
  }

  Future<ApiResult<MealDetailsModel>> getMealDetailsById(int mealId) async {
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
