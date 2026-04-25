import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/domain/use_cases/get_meal_details_by_id_usecase.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_events.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';

import 'meals_cubit_test.mocks.dart';

@GenerateMocks([GetMealDetailsByIdUsecase])
void main() {
  late MockGetMealDetailsByIdUsecase mockUsecase;
  late MealsCubit cubit;

  setUp(() {
    mockUsecase = MockGetMealDetailsByIdUsecase();
    cubit = MealsCubit(mockUsecase);
  });

  setUpAll(() {
    provideDummy<ApiResult<MealDetailsModel>>(
      SuccessApiResult<MealDetailsModel>(data: MealDetailsModel()),
    );
  });

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

  group("GetMealDetailsIntent", () {
    blocTest<MealsCubit, MealsStates>(
      'emits [loading → success]',
      build: () {
        when(
          mockUsecase.call(mealId: anyNamed('mealId')),
        ).thenAnswer((_) async => SuccessApiResult(data: tMealDetailsModel));

        return cubit;
      },

      act: (cubit) => cubit.doIntent(GetMealDetailsIntent(mealId: 1)),

      expect: () => [
        isA<MealsStates>().having(
          (s) => s.mealDetailsResource.status,
          'loading',
          Status.loading,
        ),
        isA<MealsStates>().having(
          (s) => s.mealDetailsResource.status,
          'success',
          Status.success,
        ),
      ],

      verify: (_) {
        verify(mockUsecase.call(mealId: 1)).called(1);

        verifyNoMoreInteractions(mockUsecase);
      },
    );

    blocTest<MealsCubit, MealsStates>(
      'emits error when usecase fails',
      build: () {
        when(
          mockUsecase.call(mealId: anyNamed('mealId')),
        ).thenAnswer((_) async => ErrorApiResult(error: "error"));

        return cubit;
      },

      act: (cubit) => cubit.doIntent(GetMealDetailsIntent(mealId: 1)),

      expect: () => [
        isA<MealsStates>().having(
          (s) => s.mealDetailsResource.status,
          'loading',
          Status.loading,
        ),
        isA<MealsStates>().having(
          (s) => s.mealDetailsResource.status,
          'error',
          Status.error,
        ),
      ],

      verify: (_) {
        verify(mockUsecase.call(mealId: 1)).called(1);

        verifyNoMoreInteractions(mockUsecase);
      },
    );
  });
}
