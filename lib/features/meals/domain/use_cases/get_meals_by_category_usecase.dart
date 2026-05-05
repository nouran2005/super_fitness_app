import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';
import 'package:super_fitness_app/features/meals/domain/repositories/meals_repository.dart';

@injectable
class GetMealsByCategoryUsecase {
  final MealsRepository mealsRepository;
  GetMealsByCategoryUsecase({required this.mealsRepository});

  Future<ApiResult<MealsByCategoryModel>> call({
    required String category,
  }) async {
    return await mealsRepository.getMealsByCategory(category);
  }
}
