import 'package:super_fitness_app/features/meals/data/models/response/meals_categories_dto.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';

extension MealsCategoriesExtension on MealsCategoriesDto {
  MealsCategoriesModel toMealsCategoriesModel() {
    return MealsCategoriesModel(
      categories: categories?.map((e) => e?.toCategoriesModel()).toList(),
    );
  }
}

extension CategoryExtension on CategoriesDto {
  CategoriesModel toCategoriesModel() {
    return CategoriesModel(
      idCategory: idCategory,
      strCategory: strCategory,
      strCategoryThumb: strCategoryThumb,
      strCategoryDescription: strCategoryDescription,
    );
  }
}
