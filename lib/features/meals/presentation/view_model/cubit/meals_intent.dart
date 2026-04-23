sealed class MealsIntent {}

class GetMealsCategoriesIntent extends MealsIntent {
  final int? initialIndex;
  GetMealsCategoriesIntent({this.initialIndex});
}

class SelectCategoryEvent extends MealsIntent {
  final int selectedIndex;
  SelectCategoryEvent({required this.selectedIndex});
}
