sealed class MealsIntent {}

class GetMealsCategoriesIntent extends MealsIntent {}

class SelectCategoryEvent extends MealsIntent {
  final int selectedIndex;
  SelectCategoryEvent({required this.selectedIndex});
}
