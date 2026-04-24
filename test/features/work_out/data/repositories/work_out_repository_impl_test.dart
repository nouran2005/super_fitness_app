import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:super_fitness_app/app/core/network/api_result.dart';
import 'package:super_fitness_app/features/work_out/data/datasources/work_out_remote_data_source_contract.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_by_muscle_group_response.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_group_response.dart';
import 'package:super_fitness_app/features/work_out/data/repositories/work_out_repository_impl.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_by_muscle_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_group_response_entity.dart';

class MockWorkOutRemoteDataSource extends Mock
    implements WorkOutRemoteDataSourceContract {}

void main() {
  late WorkOutRepositoryImpl repository;
  late MockWorkOutRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockWorkOutRemoteDataSource();
    repository = WorkOutRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('WorkOutRepositoryImpl', () {
    test(
      'getAllMusclesGroup should return SuccessApiResult with entity when remote call is success',
      () async {
        // arrange
        final tResponse = AllMusclesGroupResponse(musclesGroup: []);
        when(
          () => mockRemoteDataSource.getAllMusclesGroup(
            language: any(named: 'language'),
          ),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponse));

        // act
        final result = await repository.getAllMusclesGroup(language: 'en');

        // assert
        expect(result, isA<SuccessApiResult<AllMusclesGroupResponseEntity>>());
        verify(
          () => mockRemoteDataSource.getAllMusclesGroup(language: 'en'),
        ).called(1);
      },
    );

    test(
      'getAllMusclesByMuscleGroup should return SuccessApiResult with entity when remote call is success',
      () async {
        // arrange
        final tResponse = AllMusclesByMuscleGroupResponse(muscles: []);
        when(
          () => mockRemoteDataSource.getAllMusclesByMuscleGroup(
            language: any(named: 'language'),
            muscleGroupId: any(named: 'muscleGroupId'),
          ),
        ).thenAnswer((_) async => SuccessApiResult(data: tResponse));

        // act
        final result = await repository.getAllMusclesByMuscleGroup(
          language: 'en',
          muscleGroupId: '1',
        );

        // assert
        expect(
          result,
          isA<SuccessApiResult<AllMusclesByMuscleGroupResponseEntity>>(),
        );
        verify(
          () => mockRemoteDataSource.getAllMusclesByMuscleGroup(
            language: 'en',
            muscleGroupId: '1',
          ),
        ).called(1);
      },
    );

    test(
      'getAllMusclesGroup should return ErrorApiResult when remote call fails',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getAllMusclesGroup(
            language: any(named: 'language'),
          ),
        ).thenAnswer((_) async => ErrorApiResult(error: 'Error'));

        // act
        final result = await repository.getAllMusclesGroup(language: 'en');

        // assert
        expect(result, isA<ErrorApiResult<AllMusclesGroupResponseEntity>>());
        expect((result as ErrorApiResult).error, 'Error');
      },
    );
  });
}
