import 'package:json_annotation/json_annotation.dart';

part 'meals_categories_dto.g.dart';

@JsonSerializable()
class MealsCategoriesDto {
  @JsonKey(name: 'categories')
  final List<CategoriesDto?>? categories;

  MealsCategoriesDto({this.categories});

  factory MealsCategoriesDto.fromJson(Map<String, dynamic> json) =>
      _$MealsCategoriesDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MealsCategoriesDtoToJson(this);
}

@JsonSerializable()
class CategoriesDto {
  @JsonKey(name: 'idCategory')
  final String? idCategory;
  @JsonKey(name: 'strCategory')
  final String? strCategory;
  @JsonKey(name: 'strCategoryThumb')
  final String? strCategoryThumb;
  @JsonKey(name: 'strCategoryDescription')
  final String? strCategoryDescription;

  CategoriesDto({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory CategoriesDto.fromJson(Map<String, dynamic> json) =>
      _$CategoriesDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesDtoToJson(this);
}
