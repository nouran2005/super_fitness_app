import 'package:super_fitness_app/features/meals/data/models/response/meals_details_dto.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';

extension MealDetailsDtoExtension on MealsDetailsDto {
  MealDetailsModel toMealDetailsModel() {
    return MealDetailsModel(
      meals: meals?.map((meal) => meal?.toMealDetails()).toList(),
    );
  }
}

extension DetailsDtoExtension on DetailsDto {
  DetailsModel toMealDetails() {
    return DetailsModel(
      idMeal: idMeal,
      strMeal: strMeal,
      strInstructions: strInstructions,
      strMealThumb: strMealThumb,
      dateModified: dateModified,
      strYoutube: strYoutube,
      strIngredient1: strIngredient1,
      strIngredient2: strIngredient2,
      strIngredient3: strIngredient3,
      strIngredient4: strIngredient4,
      strIngredient5: strIngredient5,
      strIngredient6: strIngredient6,
      strIngredient7: strIngredient7,
      strIngredient8: strIngredient8,
      strIngredient9: strIngredient9,
      strIngredient10: strIngredient10,
      strIngredient11: strIngredient11,
      strIngredient12: strIngredient12,
      strIngredient13: strIngredient13,
      strIngredient14: strIngredient14,
      strIngredient15: strIngredient15,
      strIngredient16: strIngredient16,
      strIngredient17: strIngredient17,
      strIngredient18: strIngredient18,
      strIngredient19: strIngredient19,
      strIngredient20: strIngredient20,
      strMeasure1: strMeasure1,
      strMeasure2: strMeasure2,
      strMeasure3: strMeasure3,
      strMeasure4: strMeasure4,
      strMeasure5: strMeasure5,
      strMeasure6: strMeasure6,
      strMeasure7: strMeasure7,
      strMeasure8: strMeasure8,
      strMeasure9: strMeasure9,
      strMeasure10: strMeasure10,
      strMeasure11: strMeasure11,
      strMeasure12: strMeasure12,
      strMeasure13: strMeasure13,
      strMeasure14: strMeasure14,
      strMeasure15: strMeasure15,
      strMeasure16: strMeasure16,
      strMeasure17: strMeasure17,
      strMeasure18: strMeasure18,
      strMeasure19: strMeasure19,
      strMeasure20: strMeasure20,
      strArea: strArea,
      strCategory: strCategory,
      strTags: strTags,
      strMealAlternate: strMealAlternate,
      strSource: strSource,
      strImageSource: strImageSource,
      strCreativeCommonsConfirmed: strCreativeCommonsConfirmed,
    );
  }
}
