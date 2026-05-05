import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/meals/data/extension/meal_details_dto_extension.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_details_dto.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';

void main() {
  group('MealDetailsDtoExtension', () {
    test('should convert MealsDetailsDto to MealDetailsModel correctly', () {
      final dto = MealsDetailsDto(
        meals: [
          DetailsDto(
            idMeal: "1",
            strMeal: "Chicken Soup",
            strInstructions: "Cook well",
            strMealThumb: "img",
            strYoutube: "youtube.com/video",
            strIngredient1: "Chicken",
            strMeasure1: "1kg",
            strArea: "American",
            strCategory: "Soup",
          ),
        ],
      );

      final result = dto.toMealDetailsModel();

      expect(result, isA<MealDetailsModel>());
      expect(result.meals?.length, 1);

      final meal = result.meals?.first;

      expect(meal?.idMeal, "1");
      expect(meal?.strMeal, "Chicken Soup");
      expect(meal?.strInstructions, "Cook well");
      expect(meal?.strMealThumb, "img");
      expect(meal?.strYoutube, "youtube.com/video");
      expect(meal?.strIngredient1, "Chicken");
      expect(meal?.strMeasure1, "1kg");
      expect(meal?.strArea, "American");
      expect(meal?.strCategory, "Soup");
    });

    test('should handle null values safely', () {
      final dto = MealsDetailsDto(meals: null);

      final result = dto.toMealDetailsModel();

      expect(result.meals, isNull);
    });
  });

  group('DetailsDtoExtension', () {
    test('should convert DetailsDto to DetailsModel correctly', () {
      final dto = DetailsDto(
        idMeal: "2",
        strMeal: "Beef Burger",
        strInstructions: "Grill it",
        strMealThumb: "img2",
        strYoutube: "youtube.com/burger",
        strIngredient1: "Beef",
        strMeasure1: "200g",
        strArea: "American",
        strCategory: "Fast Food",
      );

      final result = dto.toMealDetails();

      expect(result, isA<DetailsModel>());
      expect(result.idMeal, "2");
      expect(result.strMeal, "Beef Burger");
      expect(result.strInstructions, "Grill it");
      expect(result.strMealThumb, "img2");
      expect(result.strYoutube, "youtube.com/burger");
      expect(result.strIngredient1, "Beef");
      expect(result.strMeasure1, "200g");
      expect(result.strArea, "American");
      expect(result.strCategory, "Fast Food");
    });
  });
}
