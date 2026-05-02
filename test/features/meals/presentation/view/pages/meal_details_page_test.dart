import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/meals/domain/entities/meal_details_model.dart';
import 'package:super_fitness_app/features/meals/presentation/view/pages/meal_details_page.dart';
import 'package:super_fitness_app/features/meals/presentation/view/widgets/meal_details_ingredients_list.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_intent.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../../../../helpers/pump_app.dart';

class MockMealsCubit extends MockCubit<MealsStates> implements MealsCubit {}

void main() {
  late MockMealsCubit mockCubit;

  setUpAll(() {
    getIt.allowReassignment = true;
    registerFallbackValue(GetMealsCategoriesIntent());
  });

  setUp(() {
    mockCubit = MockMealsCubit();
    // Register the mock in GetIt because MealDetailsPage uses getIt<MealsCubit>()
    getIt.registerSingleton<MealsCubit>(mockCubit);

    // Default mock response for doIntent to avoid errors if called
    when(() => mockCubit.doIntent(any())).thenReturn(null);
  });

  tearDown(() {
    getIt.unregister<MealsCubit>();
  });

  group("MealDetailsPage Widget Tests", () {
    testWidgets('should show loading indicator', (tester) async {
      when(
        () => mockCubit.state,
      ).thenReturn(MealsStates(mealDetailsResource: Resource.loading()));

      await tester.pumpLocalizedWidget(
        const MealDetailsPage(mealId: "1", meals: []),
        settle: false,
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show error state', (tester) async {
      when(() => mockCubit.state).thenReturn(
        MealsStates(
          mealDetailsResource: Resource.error("Something went wrong"),
        ),
      );

      await tester.pumpLocalizedWidget(
        const MealDetailsPage(mealId: "1", meals: []),
        settle: false,
      );

      expect(find.text("Something went wrong"), findsOneWidget);
    });

    testWidgets('should render meal details correctly', (tester) async {
      final mealModel = MealDetailsModel(
        meals: [
          DetailsModel(
            idMeal: "1",
            strMeal: "Chicken Soup",
            strMealThumb: "https://image.com",
            strYoutube: "https://www.youtube.com/watch?v=fJ9rUzIMcZQ",
            strIngredient1: "Chicken",
            strMeasure1: "1kg",
          ),
        ],
      );

      when(() => mockCubit.state).thenReturn(
        MealsStates(mealDetailsResource: Resource.success(mealModel)),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(
          const MealDetailsPage(mealId: "1", meals: []),
          settle: false,
        );
        await tester.pump();

        expect(find.text('Chicken Soup'), findsOneWidget);
        expect(find.byType(MealsIngredientsList), findsOneWidget);
      });
    });
  });
}
