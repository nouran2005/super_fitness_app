import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_by_category_dto.dart';

void main() {
  group("MealsByCategoryDto Tests", () {
    test('should parse JSON correctly (fromJson)', () {
      final json = {
        "meals": [
          {"strMeal": "Chicken Soup", "strMealThumb": "img", "idMeal": "10"},
        ],
      };

      final dto = MealsByCategoryDto.fromJson(json);

      expect(dto.meals, isNotNull);
      expect(dto.meals!.length, 1);
      expect(dto.meals!.first!.strMeal, "Chicken Soup");
      expect(dto.meals!.first!.idMeal, "10");
    });

    test('should handle null meals safely', () {
      final json = {"meals": null};

      final dto = MealsByCategoryDto.fromJson(json);

      expect(dto.meals, isNull);
    });

    test('should handle empty meals list', () {
      final json = {"meals": []};

      final dto = MealsByCategoryDto.fromJson(json);

      expect(dto.meals, isEmpty);
    });
  });

  group("MealsDto Tests", () {
    test('should parse MealsDto from JSON correctly', () {
      final json = {
        "strMeal": "Pizza",
        "strMealThumb": "img_url",
        "idMeal": "99",
      };

      final meal = MealsDto.fromJson(json);

      expect(meal.strMeal, "Pizza");
      expect(meal.strMealThumb, "img_url");
      expect(meal.idMeal, "99");
    });

    test('should convert MealsDto to JSON correctly', () {
      final meal = MealsDto(
        strMeal: "Burger",
        strMealThumb: "img",
        idMeal: "5",
      );

      final json = meal.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['strMeal'], "Burger");
      expect(json['strMealThumb'], "img");
      expect(json['idMeal'], "5");
    });
  });
}
