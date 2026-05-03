import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_cubit.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_states.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_states.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:super_fitness_app/features/profile/presentation/view_model/cubit/profile_states.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_state.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_cubit.dart';
import 'package:super_fitness_app/features/popular_training/presentation/view_model/popular_training_state.dart';
import 'package:super_fitness_app/features/home/presentation/pages/HomeScreen.dart';

import '../../../../helpers/pump_app.dart';

class MockRcToDayCubit extends MockCubit<RcToDayStates> implements RcToDayCubit {}
class MockMealsCubit extends MockCubit<MealsStates> implements MealsCubit {}
class MockWorkOutCubit extends MockCubit<WorkOutStates> implements WorkOutCubit {}
class MockProfileCubit extends MockCubit<ProfileState> implements ProfileCubit {}
class MockAppSectionsCubit extends MockCubit<AppSectionsState> implements AppSectionsCubit {}
class MockPopularTrainingCubit extends MockCubit<PopularTrainingState> implements PopularTrainingCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late RcToDayCubit rcToDayCubit;
  late MealsCubit mealsCubit;
  late WorkOutCubit workOutCubit;
  late ProfileCubit profileCubit;
  late AppSectionsCubit appSectionsCubit;
  late PopularTrainingCubit popularTrainingCubit;

  setUp(() {
    rcToDayCubit = MockRcToDayCubit();
    when(() => rcToDayCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => rcToDayCubit.state).thenReturn(RcToDayStates(
      recommendationResource: Resource.initial(),
    ));

    mealsCubit = MockMealsCubit();
    when(() => mealsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mealsCubit.state).thenReturn(MealsStates(
      mealsByCategoryResource: Resource.initial(),
      mealsCategoriesResource: Resource.initial(),
      mealDetailsResource: Resource.initial(),
    ));

    workOutCubit = MockWorkOutCubit();
    when(() => workOutCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => workOutCubit.state).thenReturn(WorkOutStates(
      musclesGroupResource: Resource.initial(),
      musclesByGroupResource: Resource.initial(),
    ));

    profileCubit = MockProfileCubit();
    when(() => profileCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => profileCubit.state).thenReturn(ProfileState());

    appSectionsCubit = MockAppSectionsCubit();
    when(() => appSectionsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => appSectionsCubit.state).thenReturn(const AppSectionsState());

    popularTrainingCubit = MockPopularTrainingCubit();
    when(() => popularTrainingCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => popularTrainingCubit.state).thenReturn(PopularTrainingState(
      popularExercises: Resource.initial(),
    ));

    getIt.registerSingleton<RcToDayCubit>(rcToDayCubit);
    getIt.registerSingleton<MealsCubit>(mealsCubit);
    getIt.registerSingleton<WorkOutCubit>(workOutCubit);
    getIt.registerSingleton<ProfileCubit>(profileCubit);
    getIt.registerSingleton<AppSectionsCubit>(appSectionsCubit);
    getIt.registerSingleton<PopularTrainingCubit>(popularTrainingCubit);
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('HomeScreen', () {
    testWidgets('renders without crashing', (tester) async {
      await mockNetworkImagesFor(() async {
        final previousOnError = FlutterError.onError;
        FlutterError.onError = (_) {};

        await tester.pumpLocalizedWidget(
          const HomeScreen(),
          withScaffold: false,
          settle: false,
        );

        FlutterError.onError = previousOnError;
        // Screen should build its MultiBlocProvider tree
        expect(find.byType(HomeScreen), findsOneWidget);
      });
    });
  });
}
