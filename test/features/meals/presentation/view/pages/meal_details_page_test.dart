import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/presentation/view/pages/meal_details_page.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meal_details_ingredients_list.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../helpers/pump_app.dart';

import 'meals_page_test.mocks.dart';

void main() {
  late MockMealsCubit mockCubit;

  setUp(() async {
    await getIt.reset();
    mockCubit = MockMealsCubit();
    getIt.registerFactory<MealsCubit>(() => mockCubit);
    when(mockCubit.stream).thenAnswer((_) => const Stream<MealsStates>.empty());
  });

  group("MealDetailsPage Widget Tests", () {
    testWidgets('should show loading indicator', (tester) async {
      when(
        mockCubit.state,
      ).thenReturn(MealsStates(mealDetailsResource: Resource.loading()));

      await tester.pumpLocalizedWidget(
        MealDetailsPage(mealId: "1", meals: []),
        settle: false,
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error state', (tester) async {
      when(mockCubit.state).thenReturn(
        MealsStates(
          mealDetailsResource: Resource.error("Something went wrong"),
        ),
      );

      await tester.pumpLocalizedWidget(
        MealDetailsPage(mealId: "1", meals: []),
        settle: false,
      );

      expect(find.text("Something went wrong"), findsOneWidget);
    });

    testWidgets('should render meal details correctly', (tester) async {
      final mealModel = MealDetailsModel(
        meals: [
          DetailsModel(
            strMeal: "Chicken Soup",
            strMealThumb: "https://image.com",
            strYoutube: "https://www.youtube.com/watch?v=fJ9rUzIMcZQ",
            strIngredient1: "Chicken",
            strMeasure1: "1kg",
          ),
        ],
      );

      when(mockCubit.state).thenReturn(
        MealsStates(mealDetailsResource: Resource.success(mealModel)),
      );

      await tester.pumpLocalizedWidget(
        MealDetailsPage(mealId: "1", meals: []),
        settle: false,
      );
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Chicken Soup'), findsOneWidget);
      expect(
        find.byKey(const Key('youtube_player_placeholder')),
        findsOneWidget,
      );
      expect(find.byType(MealsIngredientsList), findsOneWidget);
    });
  });
}
