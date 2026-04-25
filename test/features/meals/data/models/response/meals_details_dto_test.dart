import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_details_dto.dart';

void main() {
  group('MealsDetailsDto', () {
    test('should create object correctly', () {
      final dto = MealsDetailsDto(
        meals: [
          DetailsDto(
            idMeal: "1",
            strMeal: "Chicken",
            strCategory: "Dinner",
            strArea: "Egypt",
            strInstructions: "Cook it well",
            strMealThumb: "image.jpg",
            strYoutube: "youtube.com",
          ),
        ],
      );

      expect(dto.meals?.first?.idMeal, "1");
      expect(dto.meals?.first?.strMeal, "Chicken");
    });

    test('should create from JSON correctly', () {
      final json = {
        "meals": [
          {
            "idMeal": "1",
            "strMeal": "Chicken",
            "strCategory": "Dinner",
            "strArea": "Egypt",
          },
        ],
      };

      final dto = MealsDetailsDto.fromJson(json);

      expect(dto.meals?.first?.idMeal, "1");
      expect(dto.meals?.first?.strMeal, "Chicken");
      expect(dto.meals?.first?.strArea, "Egypt");
    });
  });

  group('DetailsDto edge cases', () {
    test('should handle null values safely', () {
      final dto = DetailsDto();

      expect(dto.idMeal, isNull);
      expect(dto.strMeal, isNull);
      expect(dto.strInstructions, isNull);
    });
  });
}
