import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/muscle_group_entity.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscle_group_sections.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_events.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_states.dart';

import '../../../../../helpers/pump_app.dart';

class MockWorkOutCubit extends Mock implements WorkOutCubit {}

void main() {
  setUpAll(() {
    registerFallbackValue(const GetAllMusclesGroup(language: 'en'));
  });

  late WorkOutCubit cubit;

  setUp(() {
    cubit = MockWorkOutCubit();
    when(() => cubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => cubit.close()).thenAnswer((_) async {});
    when(() => cubit.doEvent(any())).thenReturn(null);
    getIt.registerSingleton<WorkOutCubit>(cubit);
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets(
    'MuscleGroupSections displays horizontal chips and handles selection',
    (tester) async {
      final groups = [
        MuscleGroupEntity(id: '1', name: 'Back'),
        MuscleGroupEntity(id: '2', name: 'Chest'),
      ];

      when(() => cubit.state).thenReturn(
        WorkOutStates(
          musclesGroupResource: Resource.success(
            AllMusclesGroupResponseEntity(musclesGroup: groups),
          ),
          selectedGroupId: '1',
        ),
      );

      await tester.pumpLocalizedWidget(
        BlocProvider.value(value: cubit, child: const MuscleGroupSections()),
        settle: false,
      );
      await tester.pump();

      expect(find.text('Back'), findsOneWidget);
      expect(find.text('Chest'), findsOneWidget);

      // Tap on second group
      await tester.tap(find.text('Chest'));
      await tester.pump();

      // Verify event was triggered (GetMusclesByGroup)
      verify(() => cubit.doEvent(any())).called(1);
    },
  );
}
