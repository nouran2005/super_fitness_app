import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/config/di/di.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_by_muscle_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscle_card.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscles_grid.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_states.dart';

import '../../../../../helpers/pump_app.dart';

class MockWorkOutCubit extends Mock implements WorkOutCubit {}

void main() {
  late WorkOutCubit cubit;

  setUp(() {
    cubit = MockWorkOutCubit();
    when(() => cubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => cubit.close()).thenAnswer((_) async {});
    getIt.registerSingleton<WorkOutCubit>(cubit);
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('MusclesGrid displays list of MuscleCards on success', (
    tester,
  ) async {
    final muscles = [
      MuscleEntity(id: '1', name: 'Biceps', image: 'url'),
      MuscleEntity(id: '2', name: 'Triceps', image: 'url'),
    ];

    when(() => cubit.state).thenReturn(
      WorkOutStates(
        musclesByGroupResource: Resource.success(
          AllMusclesByMuscleGroupResponseEntity(muscles: muscles),
        ),
      ),
    );

    await tester.pumpLocalizedWidget(
      BlocProvider.value(value: cubit, child: const MusclesGrid()),
      settle: false,
    );
    await tester.pump();

    expect(find.byType(MuscleCard), findsNWidgets(2));
    expect(find.text('Biceps'), findsOneWidget);
    expect(find.text('Triceps'), findsOneWidget);
  });

  testWidgets('MusclesGrid shows error message on failure', (tester) async {
    when(() => cubit.state).thenReturn(
      WorkOutStates(
        musclesByGroupResource: Resource.error('Something went wrong'),
      ),
    );

    await tester.pumpLocalizedWidget(
      BlocProvider.value(value: cubit, child: const MusclesGrid()),
      settle: false,
    );
    await tester.pump();

    expect(find.text('Something went wrong'), findsOneWidget);
  });
}
