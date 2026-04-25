import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/meals/data/datasources/meals_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/meals/data/models/response/meals_details_dto.dart';
import 'package:super_fitness_app/features/meals/data/repositories/meals_repository_impl.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';

import 'meals_repository_impl_test.mocks.dart';

@GenerateMocks([MealsRemoteDataSourceContract])
void main() {
  late MockMealsRemoteDataSourceContract mockDataSource;
  late MealsRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockMealsRemoteDataSourceContract();
    repository = MealsRepositoryImpl(remoteDataSource: mockDataSource);
  });

  setUpAll(() {
    provideDummy<ApiResult<MealsDetailsDto>>(
      SuccessApiResult<MealsDetailsDto>(data: MealsDetailsDto()),
    );
  });

  group("MealsRepositoryImpl.getMealDetailsById", () {
    final tDetailsDto = MealsDetailsDto(
      meals: [
        DetailsDto(
          idMeal: "1",
          strMeal: "Chicken Soup",
          strCategory: "Dinner",
          strArea: "Egypt",
        ),
      ],
    );

    test(
      'should return SuccessApiResult<MealDetailsModel> when success',
      () async {
        when(
          mockDataSource.getMealDetailsById(any),
        ).thenAnswer((_) async => SuccessApiResult(data: tDetailsDto));

        final result = await repository.getMealDetailsById(1);

        expect(result, isA<SuccessApiResult<MealDetailsModel>>());

        final data = (result as SuccessApiResult<MealDetailsModel>).data;

        expect(data.meals?.first?.idMeal, "1");
        expect(data.meals?.first?.strMeal, "Chicken Soup");
        expect(data.meals?.first?.strCategory, "Dinner");

        verify(mockDataSource.getMealDetailsById(any)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test('should return ErrorApiResult when fails', () async {
      when(
        mockDataSource.getMealDetailsById(any),
      ).thenAnswer((_) async => ErrorApiResult(error: "error"));

      final result = await repository.getMealDetailsById(1);

      expect(result, isA<ErrorApiResult<MealDetailsModel>>());

      expect((result as ErrorApiResult).error, "error");

      verify(mockDataSource.getMealDetailsById(any)).called(1);
    });
  });
}
