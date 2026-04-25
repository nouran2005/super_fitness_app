import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/domain/repositories/meals_repository.dart';

@injectable
class GetMealDetailsByIdUsecase {
  final MealsRepository mealsRepository;
  GetMealDetailsByIdUsecase({required this.mealsRepository});

  Future<ApiResult<MealDetailsModel>> call({required String mealId}) async {
    return await mealsRepository.getMealDetailsById(mealId);
  }
}
