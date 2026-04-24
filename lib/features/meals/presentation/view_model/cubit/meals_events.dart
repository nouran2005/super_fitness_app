sealed class MealsIntent {}

class GetMealDetailsIntent extends MealsIntent {
  final int mealId;
  GetMealDetailsIntent({required this.mealId});
}
