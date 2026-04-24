import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:super_fitness_app/features/home/domain/model/recommendation_entity.dart';
import 'package:super_fitness_app/features/home/domain/usecase/get_random_muscles_usecase.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_cubit.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_intents.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_states.dart';

import 'Rc_to_day_cubit_test.mocks.dart';

@GenerateMocks([GetRandomMusclesUseCase])
void main() {
  late RcToDayCubit cubit;
  late MockGetRandomMusclesUseCase mockGetRandomMusclesUseCase;

  setUp(() {
    mockGetRandomMusclesUseCase = MockGetRandomMusclesUseCase();
    cubit = RcToDayCubit(mockGetRandomMusclesUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  group('RcToDayCubit', () {
    test('initial state is correct', () {
      expect(cubit.state.recommendationResource.isInitial, isTrue);
    });

    blocTest<RcToDayCubit, RcToDayStates>(
      'emits [loading, success] when GetRandomMusclesIntent is added and succeeds',
      build: () {
        when(mockGetRandomMusclesUseCase.execute()).thenAnswer(
          (_) async => const RecommendationEntity(
            message: 'Success',
            totalMuscles: 0,
            muscles: [],
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetRandomMusclesIntent()),
      expect: () => [
        isA<RcToDayStates>().having(
          (s) => s.recommendationResource.isLoading,
          'isLoading is true',
          true,
        ),
        isA<RcToDayStates>().having(
          (s) => s.recommendationResource.isSuccess,
          'isSuccess is true',
          true,
        ),
      ],
    );

    blocTest<RcToDayCubit, RcToDayStates>(
      'emits [loading, error] when GetRandomMusclesIntent is added and fails',
      build: () {
        when(
          mockGetRandomMusclesUseCase.execute(),
        ).thenThrow(Exception('Error'));
        return cubit;
      },
      act: (cubit) => cubit.doIntent(GetRandomMusclesIntent()),
      expect: () => [
        isA<RcToDayStates>().having(
          (s) => s.recommendationResource.isLoading,
          'isLoading is true',
          true,
        ),
        isA<RcToDayStates>().having(
          (s) => s.recommendationResource.isError,
          'isError is true',
          true,
        ),
      ],
    );
  });
}
