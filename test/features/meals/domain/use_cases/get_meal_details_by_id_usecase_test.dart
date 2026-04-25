import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/domain/repositories/meals_repository.dart';
import 'package:super_fitness_app/features/meals/domain/use_cases/get_meal_details_by_id_usecase.dart';

import 'get_meal_details_by_id_usecase_test.mocks.dart';

@GenerateMocks([MealsRepository])
void main() {
  late MockMealsRepository mockRepository;
  late GetMealDetailsByIdUsecase usecase;

  setUp(() {
    mockRepository = MockMealsRepository();
    usecase = GetMealDetailsByIdUsecase(mealsRepository: mockRepository);
  });

  setUpAll(() {
    provideDummy<ApiResult<MealDetailsModel>>(
      SuccessApiResult<MealDetailsModel>(data: MealDetailsModel()),
    );
  });

  const tMealId = "1";

  final tMealDetailsModel = MealDetailsModel(
    meals: [
      DetailsModel(
        idMeal: "1",
        strMeal: "Chicken Soup",
        strCategory: "Dinner",
        strArea: "Egypt",
      ),
    ],
  );

  group("GetMealDetailsByIdUsecase", () {
    test('should return SuccessApiResult when repository succeeds', () async {
      when(
        mockRepository.getMealDetailsById(tMealId),
      ).thenAnswer((_) async => SuccessApiResult(data: tMealDetailsModel));

      final result = await usecase(mealId: tMealId);

      expect(result, isA<SuccessApiResult<MealDetailsModel>>());

      final data = (result as SuccessApiResult<MealDetailsModel>).data;

      expect(data.meals?.first?.idMeal, "1");
      expect(data.meals?.first?.strMeal, "Chicken Soup");

      verify(mockRepository.getMealDetailsById(tMealId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ErrorApiResult when repository fails', () async {
      when(
        mockRepository.getMealDetailsById(tMealId),
      ).thenAnswer((_) async => ErrorApiResult(error: "error"));

      final result = await usecase(mealId: tMealId);

      expect(result, isA<ErrorApiResult<MealDetailsModel>>());

      expect((result as ErrorApiResult).error, "error");

      verify(mockRepository.getMealDetailsById(tMealId)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
