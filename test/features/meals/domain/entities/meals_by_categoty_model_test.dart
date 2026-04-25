import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meals_by_categoty_model.dart';

void main() {
  group("MealsByCategoryModel Tests", () {
    test('should create MealsByCategoryModel correctly', () {
      final model = MealsByCategoryModel(
        meals: [
          MealsModel(
            strMeal: "Chicken Soup",
            strMealThumb: "img_url",
            idMeal: "10",
          ),
        ],
      );

      expect(model.meals, isNotNull);
      expect(model.meals!.length, 1);

      final meal = model.meals!.first;

      expect(meal!.strMeal, "Chicken Soup");
      expect(meal.strMealThumb, "img_url");
      expect(meal.idMeal, "10");
    });

    test('should handle null meals list', () {
      final model = MealsByCategoryModel(meals: null);

      expect(model.meals, isNull);
    });

    test('should handle empty meals list', () {
      final model = MealsByCategoryModel(meals: []);

      expect(model.meals, isEmpty);
    });
  });

  group("MealsModel Tests", () {
    test('should create MealsModel correctly', () {
      final meal = MealsModel(
        strMeal: "Pizza",
        strMealThumb: "thumb.png",
        idMeal: "99",
      );

      expect(meal.strMeal, "Pizza");
      expect(meal.strMealThumb, "thumb.png");
      expect(meal.idMeal, "99");
    });

    test('should allow null fields', () {
      final meal = MealsModel();

      expect(meal.strMeal, isNull);
      expect(meal.strMealThumb, isNull);
      expect(meal.idMeal, isNull);
    });
  });
}
