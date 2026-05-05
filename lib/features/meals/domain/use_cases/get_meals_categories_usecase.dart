import 'package:injectable/injectable.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';
import 'package:super_fitness_app/features/meals/domain/repositories/meals_repository.dart';

@injectable
class GetMealsCategoriesUsecase {
  final MealsRepository mealsRepository;
  GetMealsCategoriesUsecase({required this.mealsRepository});

  Future<ApiResult<MealsCategoriesModel>> call() async {
    return await mealsRepository.getMealsCategories();
  }
}
