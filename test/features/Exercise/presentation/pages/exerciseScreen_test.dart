import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_cubit.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_states.dart';
import 'package:super_fitness_app/features/Exercise/presentation/pages/exerciseScreen.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/eserciseBody.dart';

import '../../../../helpers/pump_app.dart';

class MockExerciseCubit extends MockCubit<ExerciseStates>
    implements ExerciseCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ExerciseCubit cubit;

  setUp(() {
    cubit = MockExerciseCubit();
    when(() => cubit.state).thenReturn(
      ExerciseStates(
        exerciseResource: Resource.initial(),
        currentExercisesResource: Resource.initial(),
      ),
    );
    getIt.registerSingleton<ExerciseCubit>(cubit);
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('ExerciseScreen', () {
    testWidgets('renders ExerciseBody with given arguments', (tester) async {
      await tester.pumpLocalizedWidget(
        const ExerciseScreen(
          muscleGroupId: 'muscle1',
          initialExerciseId: 'ex1',
          initialDifficultyLevel: 'hard',
        ),
        withScaffold: true,
      );

      expect(find.byType(ExerciseBody), findsOneWidget);

      final exerciseBody = tester.widget<ExerciseBody>(
        find.byType(ExerciseBody),
      );
      expect(exerciseBody.muscleGroupId, 'muscle1');
      expect(exerciseBody.initialExerciseId, 'ex1');
      expect(exerciseBody.initialDifficultyLevel, 'hard');
    });
  });
}
