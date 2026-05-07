import 'package:flutter_test/flutter_test.dart';
import 'package:super_fitness_app/features/work_out/data/models/muscle_group.dart';
import 'package:super_fitness_app/features/work_out/data/models/muscles_group.dart';
import 'package:super_fitness_app/features/work_out/data/models/muscles.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_by_muscle_group_response.dart';
import 'package:super_fitness_app/features/work_out/data/models/responses/all_muscles_group_response.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/muscle_group_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/muscle_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_by_muscle_group_response_entity.dart';
import 'package:super_fitness_app/features/work_out/domain/entities/all_muscles_group_response_entity.dart';

void main() {
  // ──────────────────────────────────────────────
  // MuscleGroup
  // ──────────────────────────────────────────────
  group('MuscleGroup', () {
    final tJson = {'_id': 'mg1', 'name': 'Chest'};

    test('fromJson should return a valid model', () {
      // act
      final result = MuscleGroup.fromJson(tJson);

      // assert
      expect(result.Id, 'mg1');
      expect(result.name, 'Chest');
    });

    test('toJson should return correct map', () {
      // arrange
      final model = MuscleGroup(Id: 'mg1', name: 'Chest');

      // act
      final result = model.toJson();

      // assert
      expect(result['_id'], 'mg1');
      expect(result['name'], 'Chest');
    });

    test('toEntity should map to MuscleGroupEntity', () {
      // arrange
      final model = MuscleGroup(Id: 'mg1', name: 'Chest');

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<MuscleGroupEntity>());
      expect(entity.id, 'mg1');
      expect(entity.name, 'Chest');
    });
  });

  // ──────────────────────────────────────────────
  // MusclesGroup
  // ──────────────────────────────────────────────
  group('MusclesGroup', () {
    final tJson = {'_id': 'mgs1', 'name': 'Back'};

    test('fromJson should return a valid model', () {
      // act
      final result = MusclesGroup.fromJson(tJson);

      // assert
      expect(result.Id, 'mgs1');
      expect(result.name, 'Back');
    });

    test('toJson should return correct map', () {
      // arrange
      final model = MusclesGroup(Id: 'mgs1', name: 'Back');

      // act
      final result = model.toJson();

      // assert
      expect(result['_id'], 'mgs1');
      expect(result['name'], 'Back');
    });

    test('toEntity should map to MuscleGroupEntity', () {
      // arrange
      final model = MusclesGroup(Id: 'mgs1', name: 'Back');

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<MuscleGroupEntity>());
      expect(entity.id, 'mgs1');
      expect(entity.name, 'Back');
    });
  });

  // ──────────────────────────────────────────────
  // Muscles
  // ──────────────────────────────────────────────
  group('Muscles', () {
    final tJson = {'_id': 'm1', 'name': 'Bicep', 'image': 'bicep_url'};

    test('fromJson should return a valid model', () {
      // act
      final result = Muscles.fromJson(tJson);

      // assert
      expect(result.Id, 'm1');
      expect(result.name, 'Bicep');
      expect(result.image, 'bicep_url');
    });

    test('toJson should return correct map', () {
      // arrange
      final model = Muscles(Id: 'm1', name: 'Bicep', image: 'bicep_url');

      // act
      final result = model.toJson();

      // assert
      expect(result['_id'], 'm1');
      expect(result['name'], 'Bicep');
      expect(result['image'], 'bicep_url');
    });

    test('toEntity should map to MuscleEntity', () {
      // arrange
      final model = Muscles(Id: 'm1', name: 'Bicep', image: 'bicep_url');

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<MuscleEntity>());
      expect(entity.id, 'm1');
      expect(entity.name, 'Bicep');
      expect(entity.image, 'bicep_url');
    });
  });

  // ──────────────────────────────────────────────
  // AllMusclesGroupResponse
  // ──────────────────────────────────────────────
  group('AllMusclesGroupResponse', () {
    final tJson = {
      'message': 'success',
      'musclesGroup': [
        {'_id': 'mgs1', 'name': 'Back'},
        {'_id': 'mgs2', 'name': 'Legs'},
      ],
    };

    test('fromJson should return a valid model', () {
      // act
      final result = AllMusclesGroupResponse.fromJson(tJson);

      // assert
      expect(result.message, 'success');
      expect(result.musclesGroup?.length, 2);
      expect(result.musclesGroup?[0].name, 'Back');
      expect(result.musclesGroup?[1].Id, 'mgs2');
    });

    test('toJson should return correct map', () {
      // arrange
      final model = AllMusclesGroupResponse(
        message: 'success',
        musclesGroup: [MusclesGroup(Id: 'mgs1', name: 'Back')],
      );

      // act
      final result = model.toJson();

      // assert
      expect(result['message'], 'success');
      expect(result['musclesGroup'], isA<List>());
    });

    test('toEntity should map to AllMusclesGroupResponseEntity', () {
      // arrange
      final model = AllMusclesGroupResponse(
        message: 'success',
        musclesGroup: [
          MusclesGroup(Id: 'mgs1', name: 'Back'),
          MusclesGroup(Id: 'mgs2', name: 'Legs'),
        ],
      );

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<AllMusclesGroupResponseEntity>());
      expect(entity.message, 'success');
      expect(entity.musclesGroup?.length, 2);
      expect(entity.musclesGroup?[0].name, 'Back');
    });
  });

  // ──────────────────────────────────────────────
  // AllMusclesByMuscleGroupResponse
  // ──────────────────────────────────────────────
  group('AllMusclesByMuscleGroupResponse', () {
    final tJson = {
      'message': 'success',
      'muscleGroup': {'_id': 'mg1', 'name': 'Chest'},
      'muscles': [
        {'_id': 'm1', 'name': 'Pec Major', 'image': 'pec_url'},
        {'_id': 'm2', 'name': 'Pec Minor', 'image': 'pec_minor_url'},
      ],
    };

    test('fromJson should return a valid model', () {
      // act
      final result = AllMusclesByMuscleGroupResponse.fromJson(tJson);

      // assert
      expect(result.message, 'success');
      expect(result.muscleGroup?.name, 'Chest');
      expect(result.muscleGroup?.Id, 'mg1');
      expect(result.muscles?.length, 2);
      expect(result.muscles?[0].name, 'Pec Major');
    });

    test('toJson should return correct map', () {
      // arrange
      final model = AllMusclesByMuscleGroupResponse(
        message: 'success',
        muscleGroup: MuscleGroup(Id: 'mg1', name: 'Chest'),
        muscles: [Muscles(Id: 'm1', name: 'Pec Major', image: 'pec_url')],
      );

      // act
      final result = model.toJson();

      // assert
      expect(result['message'], 'success');
      expect(result['muscleGroup'], isNotNull);
      expect(result['muscles'], isA<List>());
    });

    test('toEntity should map to AllMusclesByMuscleGroupResponseEntity', () {
      // arrange
      final model = AllMusclesByMuscleGroupResponse(
        message: 'success',
        muscleGroup: MuscleGroup(Id: 'mg1', name: 'Chest'),
        muscles: [
          Muscles(Id: 'm1', name: 'Pec Major', image: 'pec_url'),
          Muscles(Id: 'm2', name: 'Pec Minor', image: 'pec_minor_url'),
        ],
      );

      // act
      final entity = model.toEntity();

      // assert
      expect(entity, isA<AllMusclesByMuscleGroupResponseEntity>());
      expect(entity.message, 'success');
      expect(entity.muscleGroup?.id, 'mg1');
      expect(entity.muscleGroup?.name, 'Chest');
      expect(entity.muscles?.length, 2);
      expect(entity.muscles?[0].name, 'Pec Major');
    });
  });
}
