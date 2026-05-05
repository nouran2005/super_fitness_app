import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/meals/data/extension/meals_categories_extension.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_categories_dto.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_categories_model.dart';

void main() {
  group("MealsCategoriesExtension", () {
    test('should map MealsCategoriesDto to MealsCategoriesModel correctly', () {
      final dto = MealsCategoriesDto(
        categories: [
          CategoriesDto(
            idCategory: "1",
            strCategory: "Beef",
            strCategoryThumb: "thumb_url",
            strCategoryDescription: "description",
          ),
        ],
      );

      final result = dto.toMealsCategoriesModel();

      expect(result, isA<MealsCategoriesModel>());
      expect(result.categories?.length, 1);
      expect(result.categories?.first?.idCategory, "1");
      expect(result.categories?.first?.strCategory, "Beef");
      expect(result.categories?.first?.strCategoryThumb, "thumb_url");
      expect(result.categories?.first?.strCategoryDescription, "description");
    });

    test('should handle null categories safely', () {
      final dto = MealsCategoriesDto(categories: null);

      final result = dto.toMealsCategoriesModel();

      expect(result.categories, isNull);
    });
  });

  group("CategoryExtension", () {
    test('should map CategoriesDto to CategoriesModel correctly', () {
      final dto = CategoriesDto(
        idCategory: "2",
        strCategory: "Chicken",
        strCategoryThumb: "thumb_url",
        strCategoryDescription: "delicious chicken meals",
      );

      final result = dto.toCategoriesModel();

      expect(result, isA<CategoriesModel>());
      expect(result.idCategory, "2");
      expect(result.strCategory, "Chicken");
      expect(result.strCategoryThumb, "thumb_url");
      expect(result.strCategoryDescription, "delicious chicken meals");
    });
  });
}
