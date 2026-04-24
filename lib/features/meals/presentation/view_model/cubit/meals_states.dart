import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';

class MealsStates {
  final Resource<MealDetailsModel> mealDetailsResource;

  MealsStates({Resource<MealDetailsModel>? mealDetailsResource})
    : mealDetailsResource = mealDetailsResource ?? Resource.initial();

  MealsStates copyWith({Resource<MealDetailsModel>? mealDetailsResource}) {
    return MealsStates(
      mealDetailsResource: mealDetailsResource ?? this.mealDetailsResource,
    );
  }
}
