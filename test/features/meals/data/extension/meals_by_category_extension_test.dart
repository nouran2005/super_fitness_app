import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/meals/data/extension/meals_by_category_extension.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_by_category_dto.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';

void main() {
  group("MealsByCategoryExtension", () {
    test('should map MealsByCategoryDto to MealsByCategoryModel correctly', () {
      final dto = MealsByCategoryDto(
        meals: [
          MealsDto(
            strMeal: "Beef Burger",
            strMealThumb: "image_url",
            idMeal: "1",
          ),
        ],
      );

      final result = dto.toMealsByCategoryModel();

      expect(result, isA<MealsByCategoryModel>());
      expect(result.meals?.length, 1);
      expect(result.meals?.first?.strMeal, "Beef Burger");
      expect(result.meals?.first?.idMeal, "1");
    });

    test('should handle null meals list safely', () {
      final dto = MealsByCategoryDto(meals: null);

      final result = dto.toMealsByCategoryModel();

      expect(result.meals, isNull);
    });
  });

  group("MealsExtension", () {
    test('should map MealsDto to MealsModel correctly', () {
      final dto = MealsDto(
        strMeal: "Chicken Soup",
        strMealThumb: "image_url",
        idMeal: "10",
      );

      final result = dto.toMealsModel();

      expect(result, isA<MealsModel>());
      expect(result.strMeal, "Chicken Soup");
      expect(result.strMealThumb, "image_url");
      expect(result.idMeal, "10");
    });
  });
}
