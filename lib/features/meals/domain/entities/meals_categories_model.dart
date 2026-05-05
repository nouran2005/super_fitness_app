class MealsCategoriesModel {
  final List<CategoriesModel?>? categories;
  MealsCategoriesModel({this.categories});
}

class CategoriesModel {
  final String? idCategory;
  final String? strCategory;
  final String? strCategoryThumb;
  final String? strCategoryDescription;

  CategoriesModel({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });
}
