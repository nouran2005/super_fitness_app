import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_by_muscle_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/use_cases/get_all_muscles_by_muscle_group_use_case.dart';
import 'package:super_fitness_app/features/work_out/domain/use_cases/get_all_muscles_group_use_case.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_events.dart';
import 'package:super_fitness_app/features/work_out/presentation/view_model/cubit/work_out_states.dart';

class MockGetAllMusclesGroupUseCase extends Mock
    implements GetAllMusclesGroupUseCase {}

class MockGetAllMusclesByMuscleGroupUseCase extends Mock
    implements GetAllMusclesByMuscleGroupUseCase {}

void main() {
  late WorkOutCubit cubit;
  late MockGetAllMusclesGroupUseCase mockGetAllMusclesGroupUseCase;
  late MockGetAllMusclesByMuscleGroupUseCase
  mockGetAllMusclesByMuscleGroupUseCase;

  setUp(() {
    mockGetAllMusclesGroupUseCase = MockGetAllMusclesGroupUseCase();
    mockGetAllMusclesByMuscleGroupUseCase =
        MockGetAllMusclesByMuscleGroupUseCase();
    cubit = WorkOutCubit(
      mockGetAllMusclesGroupUseCase,
      mockGetAllMusclesByMuscleGroupUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('WorkOutCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, isA<WorkOutStates>());
    });

    blocTest<WorkOutCubit, WorkOutStates>(
      'emits loading and then success when GetAllMusclesGroup is called successfully',
      build: () {
        when(
          () => mockGetAllMusclesGroupUseCase.execute(
            language: any(named: 'language'),
          ),
        ).thenAnswer(
          (_) async => SuccessApiResult(
            data: AllMusclesGroupResponseEntity(musclesGroup: []),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.doEvent(GetAllMusclesGroup(language: 'en')),
      expect: () => [
        isA<WorkOutStates>().having(
          (s) => s.musclesGroupResource.isLoading,
          'isLoading',
          true,
        ),
        isA<WorkOutStates>().having(
          (s) => s.musclesGroupResource.isSuccess,
          'isSuccess',
          true,
        ),
      ],
    );

    blocTest<WorkOutCubit, WorkOutStates>(
      'emits loading and then error when GetAllMusclesGroup fails',
      build: () {
        when(
          () => mockGetAllMusclesGroupUseCase.execute(
            language: any(named: 'language'),
          ),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Error message'));
        return cubit;
      },
      act: (cubit) => cubit.doEvent(GetAllMusclesGroup(language: 'en')),
      expect: () => [
        isA<WorkOutStates>().having(
          (s) => s.musclesGroupResource.isLoading,
          'isLoading',
          true,
        ),
        isA<WorkOutStates>().having(
          (s) => s.musclesGroupResource.isError,
          'isError',
          true,
        ),
      ],
    );

    blocTest<WorkOutCubit, WorkOutStates>(
      'emits loading and then success when GetMusclesByGroup is called successfully',
      build: () {
        when(
          () => mockGetAllMusclesByMuscleGroupUseCase.execute(
            language: any(named: 'language'),
            muscleGroupId: any(named: 'muscleGroupId'),
          ),
        ).thenAnswer(
          (_) async => SuccessApiResult(
            data: AllMusclesByMuscleGroupResponseEntity(muscles: []),
          ),
        );
        return cubit;
      },
      act: (cubit) =>
          cubit.doEvent(GetMusclesByGroup(language: 'en', muscleGroupId: '1')),
      expect: () => [
        isA<WorkOutStates>().having(
          (s) => s.musclesByGroupResource.isLoading,
          'isLoading',
          true,
        ),
        isA<WorkOutStates>().having(
          (s) => s.musclesByGroupResource.isSuccess,
          'isSuccess',
          true,
        ),
      ],
    );
  });
}
