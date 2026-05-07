import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_cubit.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_intent.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_states.dart';
import 'package:super_fitness_app/features/Exercise/presentation/pages/exerciseScreen.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/eserciseBody.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_category_tabs.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_header.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_list_view.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_stats_row.dart';

import '../../../../helpers/pump_app.dart';

class MockExerciseCubit extends MockCubit<ExerciseStates>
    implements ExerciseCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockExerciseCubit mockCubit;

  final tExercises = [
    const ExerciseEntity(
      id: '1',
      exercise: 'Push Up',
      shortYoutubeDemonstrationLink:
          'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    ),
    const ExerciseEntity(
      id: '2',
      exercise: 'Squat',
      shortYoutubeDemonstrationLink:
          'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    ),
  ];

  setUp(() {
    registerFallbackValue(
      GetExercisesRandomIntent(muscleGroupId: '', difficultyId: ''),
    );
    mockCubit = MockExerciseCubit();
    when(() => mockCubit.state).thenReturn(
      ExerciseStates(
        exerciseResource: Resource.initial(),
        currentExercisesResource: Resource.initial(),
      ),
    );
    // Register the mock cubit in GetIt
    getIt.registerSingleton<ExerciseCubit>(mockCubit);
  });

  tearDown(() async {
    await getIt.reset();
  });

  Widget createWidgetUnderTest() {
    return const ExerciseScreen(muscleGroupId: 'muscle_1');
  }

  group('ExerciseScreen Widget Tests', () {
    testWidgets('renders initial state correctly (loading exercises)', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(
        ExerciseStates(
          exerciseResource: Resource.initial(),
          currentExercisesResource: Resource.loading(),
        ),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(
          createWidgetUnderTest(),
          withScaffold: true,
          settle: false,
        );
      });

      expect(find.byType(ExerciseHeader), findsOneWidget);
      expect(find.byType(ExerciseStatsRow), findsOneWidget);
      expect(find.byType(ExerciseCategoryTabs), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders success state with exercise list', (tester) async {
      final states = StreamController<ExerciseStates>();
      addTearDown(states.close);

      whenListen(
        mockCubit,
        states.stream,
        initialState: ExerciseStates(
          exerciseResource: Resource.initial(),
          currentExercisesResource: Resource.loading(),
        ),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(
          createWidgetUnderTest(),
          withScaffold: true,
          settle: false,
        );

        states.add(
          ExerciseStates(
            exerciseResource: Resource.initial(),
            currentExercisesResource: Resource.success(tExercises),
          ),
        );

        await tester.pump();
        await tester.pump();
      });

      expect(find.byType(ExerciseListView), findsOneWidget);
      expect(find.text('Push Up'), findsAtLeast(1));
      expect(find.text('Squat'), findsOneWidget);
    });

    testWidgets('renders empty state message when no exercises found', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(
        ExerciseStates(
          exerciseResource: Resource.initial(),
          currentExercisesResource: Resource.success(const []),
        ),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(
          createWidgetUnderTest(),
          withScaffold: true,
        );
        await tester.pump();
      });

      expect(find.text('No exercises found for this level'), findsOneWidget);
    });

    testWidgets('interaction: switching categories triggers new fetch', (
      tester,
    ) async {
      when(() => mockCubit.state).thenReturn(
        ExerciseStates(
          exerciseResource: Resource.initial(),
          currentExercisesResource: Resource.success(tExercises),
        ),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(
          createWidgetUnderTest(),
          withScaffold: true,
          settle: false,
        );
        await tester.pump();
      });

      final intermediateTab = find.text('Intermediate');
      await tester.tap(intermediateTab);
      await tester.pumpAndSettle();

      verify(
        () => mockCubit.doIntent(any(that: isA<GetExercisesRandomIntent>())),
      ).called(2);
    });

    testWidgets('interaction: selecting an exercise updates the header', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());

      final states = StreamController<ExerciseStates>();
      addTearDown(states.close);

      whenListen(
        mockCubit,
        states.stream,
        initialState: ExerciseStates(
          exerciseResource: Resource.initial(),
          currentExercisesResource: Resource.loading(),
        ),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(
          createWidgetUnderTest(),
          withScaffold: true,
          settle: false,
        );

        states.add(
          ExerciseStates(
            exerciseResource: Resource.initial(),
            currentExercisesResource: Resource.success(tExercises),
          ),
        );

        await tester.pump();
        await tester.pump();

        // Ensure the exercise list item is visible before tapping
        final squatItem = find.text('Squat');
        await tester.ensureVisible(squatItem);
        await tester.tap(squatItem);
        await tester.pump();
        await tester.pump();
      });

      final headerTitle = find.descendant(
        of: find.byType(ExerciseHeader),
        matching: find.text('Squat'),
      );
      expect(headerTitle, findsOneWidget);
    });

    testWidgets('renders youtube player placeholder in test environment', (
      tester,
    ) async {
      final states = StreamController<ExerciseStates>();
      addTearDown(states.close);

      whenListen(
        mockCubit,
        states.stream,
        initialState: ExerciseStates(
          exerciseResource: Resource.initial(),
          currentExercisesResource: Resource.loading(),
        ),
      );

      await mockNetworkImagesFor(() async {
        await tester.pumpLocalizedWidget(
          createWidgetUnderTest(),
          withScaffold: true,
          settle: false,
        );

        states.add(
          ExerciseStates(
            exerciseResource: Resource.initial(),
            currentExercisesResource: Resource.success(tExercises),
          ),
        );

        await tester.pump();
        await tester.pump();
      });

      expect(
        find.byKey(const Key('youtube_player_placeholder')),
        findsOneWidget,
      );
      expect(find.text('Video Player'), findsOneWidget);
    });
  });
}
