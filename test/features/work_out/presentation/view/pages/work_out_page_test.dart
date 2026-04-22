import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shimmer/shimmer.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/app/core/widgets/empty_data_widget.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_by_muscle_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/muscle_group_entity.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/pages/work_out_page.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/work_out_body.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_events.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_states.dart';

import '../../../../../helpers/pump_app.dart';

class MockWorkOutCubit extends Mock implements WorkOutCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(GetAllMusclesGroup(language: 'en'));
  });

  late WorkOutCubit cubit;

  setUp(() {
    cubit = MockWorkOutCubit();
    when(() => cubit.state).thenReturn(WorkOutStates());
    when(() => cubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => cubit.doEvent(any())).thenReturn(null);
    when(() => cubit.close()).thenAnswer((_) async {});

    getIt.registerSingleton<WorkOutCubit>(cubit);
  });

  tearDown(() async {
    await getIt.reset();
  });

  group('WorkOutPage UI Tests', () {
    testWidgets('renders WorkOutBody initially', (tester) async {
      await tester.pumpLocalizedWidget(
        const WorkOutPage(),
        withScaffold: false,
      );

      expect(find.byType(WorkOutBody), findsOneWidget);
      expect(find.text('Workouts'), findsOneWidget);
    });

    testWidgets('shows Shimmer when loading muscle groups', (tester) async {
      when(
        () => cubit.state,
      ).thenReturn(WorkOutStates(musclesGroupResource: Resource.loading()));

      await tester.pumpLocalizedWidget(
        const WorkOutPage(),
        withScaffold: false,
        settle: false,
      );

      expect(find.byType(Shimmer), findsWidgets);
    });

    testWidgets('shows Muscle names when groups are loaded successfully', (
      tester,
    ) async {
      final mockGroups = [MuscleGroupEntity(id: '1', name: 'Abs')];
      when(() => cubit.state).thenReturn(
        WorkOutStates(
          musclesGroupResource: Resource.success(
            AllMusclesGroupResponseEntity(musclesGroup: mockGroups),
          ),
        ),
      );

      await tester.pumpLocalizedWidget(
        const WorkOutPage(),
        withScaffold: false,
      );

      expect(find.text('Abs'), findsOneWidget);
    });

    testWidgets('shows EmptyDataWidget when no muscles are found for a group', (
      tester,
    ) async {
      when(() => cubit.state).thenReturn(
        WorkOutStates(
          musclesByGroupResource: Resource.success(
            AllMusclesByMuscleGroupResponseEntity(muscles: []),
          ),
        ),
      );

      await tester.pumpLocalizedWidget(
        const WorkOutPage(),
        withScaffold: false,
      );

      expect(find.byType(EmptyDataWidget), findsOneWidget);
      expect(find.text('No workouts found'), findsOneWidget);
    });
  });
}
