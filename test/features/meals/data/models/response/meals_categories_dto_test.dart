import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_categories_dto.dart';

void main() {
  group("MealsCategoriesDto Tests", () {
    test('should parse JSON correctly (fromJson)', () {
      final json = {
        "categories": [
          {
            "idCategory": "1",
            "strCategory": "Beef",
            "strCategoryThumb": "thumb_url",
            "strCategoryDescription": "tasty beef meals",
          },
        ],
      };

      final dto = MealsCategoriesDto.fromJson(json);

      expect(dto.categories, isNotNull);
      expect(dto.categories!.length, 1);
      expect(dto.categories!.first!.idCategory, "1");
      expect(dto.categories!.first!.strCategory, "Beef");
      expect(dto.categories!.first!.strCategoryThumb, "thumb_url");
      expect(dto.categories!.first!.strCategoryDescription, "tasty beef meals");
    });

    test('should handle null categories safely', () {
      final json = {"categories": null};

      final dto = MealsCategoriesDto.fromJson(json);

      expect(dto.categories, isNull);
    });

    test('should handle empty categories list', () {
      final json = {"categories": []};

      final dto = MealsCategoriesDto.fromJson(json);

      expect(dto.categories, isEmpty);
    });
  });

  group("CategoriesDto Tests", () {
    test('should parse CategoriesDto from JSON correctly', () {
      final json = {
        "idCategory": "5",
        "strCategory": "Seafood",
        "strCategoryThumb": "thumb",
        "strCategoryDescription": "fresh seafood",
      };

      final category = CategoriesDto.fromJson(json);

      expect(category.idCategory, "5");
      expect(category.strCategory, "Seafood");
      expect(category.strCategoryThumb, "thumb");
      expect(category.strCategoryDescription, "fresh seafood");
    });

    test('should convert CategoriesDto to JSON correctly', () {
      final category = CategoriesDto(
        idCategory: "9",
        strCategory: "Dessert",
        strCategoryThumb: "img",
        strCategoryDescription: "sweet food",
      );

      final json = category.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['idCategory'], "9");
      expect(json['strCategory'], "Dessert");
      expect(json['strCategoryThumb'], "img");
      expect(json['strCategoryDescription'], "sweet food");
    });
  });
}
