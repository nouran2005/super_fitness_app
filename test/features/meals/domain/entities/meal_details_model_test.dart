import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';

void main() {
  group('MealDetailsModel', () {
    test('should create model correctly', () {
      final model = MealDetailsModel(
        meals: [
          DetailsModel(
            idMeal: "1",
            strMeal: "Chicken Soup",
            strCategory: "Dinner",
            strArea: "Egypt",
            strInstructions: "Cook well",
            strMealThumb: "image.jpg",
            strYoutube: "youtube.com",
          ),
        ],
      );

      expect(model.meals?.length, 1);
      expect(model.meals?.first?.idMeal, "1");
      expect(model.meals?.first?.strMeal, "Chicken Soup");
      expect(model.meals?.first?.strCategory, "Dinner");
    });

    test('should handle null meals list', () {
      final model = MealDetailsModel();

      expect(model.meals, isNull);
    });
  });

  group('DetailsModel', () {
    test('should create DetailsModel with values correctly', () {
      final details = DetailsModel(
        idMeal: "10",
        strMeal: "Pizza",
        strCategory: "Fast Food",
        strArea: "Italy",
        strInstructions: "Bake it",
        strMealThumb: "img.png",
        strYoutube: "yt.com",
        strIngredient1: "Cheese",
        strIngredient2: "Dough",
        strMeasure1: "100g",
        strMeasure2: "200g",
        strSource: "source.com",
      );

      expect(details.idMeal, "10");
      expect(details.strMeal, "Pizza");
      expect(details.strCategory, "Fast Food");
      expect(details.strIngredient1, "Cheese");
      expect(details.strMeasure1, "100g");
      expect(details.strSource, "source.com");
    });

    test('should allow null values safely', () {
      final details = DetailsModel();

      expect(details.idMeal, isNull);
      expect(details.strMeal, isNull);
      expect(details.strCategory, isNull);
      expect(details.strIngredient1, isNull);
    });
  });
}
