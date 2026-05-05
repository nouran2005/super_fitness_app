import 'package:json_annotation/json_annotation.dart';

part 'meals_by_category_dto.g.dart';

@JsonSerializable()
class MealsByCategoryDto {
  @JsonKey(name: 'meals')
  final List<MealsDto?>? meals;

  MealsByCategoryDto({this.meals});

  factory MealsByCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$MealsByCategoryDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MealsByCategoryDtoToJson(this);
}

@JsonSerializable()
class MealsDto {
  @JsonKey(name: 'strMeal')
  final String? strMeal;
  @JsonKey(name: 'strMealThumb')
  final String? strMealThumb;
  @JsonKey(name: 'idMeal')
  final String? idMeal;

  MealsDto({this.strMeal, this.strMealThumb, this.idMeal});

  factory MealsDto.fromJson(Map<String, dynamic> json) =>
      _$MealsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MealsDtoToJson(this);
}
