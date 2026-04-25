import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';

class MealDetailsArgs {
  final String mealId;
  final List<MealsModel> meals;

  MealDetailsArgs({required this.mealId, required this.meals});
}
