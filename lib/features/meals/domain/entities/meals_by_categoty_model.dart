class MealsByCategoryModel {
  final List<MealsModel?>? meals;

  MealsByCategoryModel({this.meals});
}

class MealsModel {
  final String? strMeal;
  final String? strMealThumb;
  final String? idMeal;

  MealsModel({this.strMeal, this.strMealThumb, this.idMeal});
}
