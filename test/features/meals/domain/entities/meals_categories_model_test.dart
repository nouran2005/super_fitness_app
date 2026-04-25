import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';

void main() {
  group("MealsCategoriesModel Tests", () {
    test('should create MealsCategoriesModel correctly', () {
      final model = MealsCategoriesModel(
        categories: [
          CategoriesModel(
            idCategory: "1",
            strCategory: "Beef",
            strCategoryThumb: "thumb_url",
            strCategoryDescription: "tasty beef meals",
          ),
        ],
      );

      expect(model.categories, isNotNull);
      expect(model.categories!.length, 1);

      final category = model.categories!.first;

      expect(category!.idCategory, "1");
      expect(category.strCategory, "Beef");
      expect(category.strCategoryThumb, "thumb_url");
      expect(category.strCategoryDescription, "tasty beef meals");
    });

    test('should handle null categories list', () {
      final model = MealsCategoriesModel(categories: null);

      expect(model.categories, isNull);
    });

    test('should handle empty categories list', () {
      final model = MealsCategoriesModel(categories: []);

      expect(model.categories, isEmpty);
    });
  });

  group("CategoriesModel Tests", () {
    test('should create CategoriesModel correctly', () {
      final category = CategoriesModel(
        idCategory: "5",
        strCategory: "Chicken",
        strCategoryThumb: "img_url",
        strCategoryDescription: "delicious chicken meals",
      );

      expect(category.idCategory, "5");
      expect(category.strCategory, "Chicken");
      expect(category.strCategoryThumb, "img_url");
      expect(category.strCategoryDescription, "delicious chicken meals");
    });

    test('should allow null fields', () {
      final category = CategoriesModel();

      expect(category.idCategory, isNull);
      expect(category.strCategory, isNull);
      expect(category.strCategoryThumb, isNull);
      expect(category.strCategoryDescription, isNull);
    });
  });
}
