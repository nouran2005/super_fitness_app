import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';

part 'ExerciseRESponse.g.dart';

@JsonSerializable()
class ExerciseResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "totalExercises")
  int? totalExercises;
  @JsonKey(name: "totalPages")
  int? totalPages;
  @JsonKey(name: "currentPage")
  int? currentPage;
  @JsonKey(name: "exercises")
  List<Exercise>? exercises;

  ExerciseResponse({
    this.message,
    this.totalExercises,
    this.totalPages,
    this.currentPage,
    this.exercises,
  });

  factory ExerciseResponse.fromJson(Map<String, dynamic> json) =>
      _$ExerciseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseResponseToJson(this);

  ExerciseResponseEntity toEntity() {
    final mappedExercises = exercises?.map((e) => e.toEntity()).toList() ?? [];

    final beginnerList = <ExerciseEntity>[];
    final intermediateList = <ExerciseEntity>[];
    final advancedList = <ExerciseEntity>[];

    for (final exercise in mappedExercises) {
      final difficulty = exercise.difficultyLevel?.toLowerCase();
      if (difficulty == 'novice' || difficulty == 'beginner') {
        beginnerList.add(exercise);
      } else if (difficulty == 'intermediate') {
        intermediateList.add(exercise);
      } else if (difficulty == 'advanced') {
        advancedList.add(exercise);
      }
    }

    final categories = [
      ExerciseCategoryEntity(name: 'Beginner', exercises: beginnerList),
      ExerciseCategoryEntity(name: 'Intermediate', exercises: intermediateList),
      ExerciseCategoryEntity(name: 'Advanced', exercises: advancedList),
    ];

    return ExerciseResponseEntity(
      message: message,
      totalExercises: totalExercises,
      totalPages: totalPages,
      currentPage: currentPage,
      exercises: mappedExercises,
      categories: categories,
    );
  }
}

@JsonSerializable()
class Exercise {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "exercise")
  String? exercise;
  @JsonKey(name: "short_youtube_demonstration")
  String? shortYoutubeDemonstration;
  @JsonKey(name: "in_depth_youtube_explanation")
  String? inDepthYoutubeExplanation;
  @JsonKey(name: "difficulty_level")
  String? difficultyLevel;
  @JsonKey(name: "target_muscle_group")
  String? targetMuscleGroup;
  @JsonKey(name: "prime_mover_muscle")
  String? primeMoverMuscle;
  @JsonKey(name: "secondary_muscle")
  dynamic secondaryMuscle;
  @JsonKey(name: "tertiary_muscle")
  dynamic tertiaryMuscle;
  @JsonKey(name: "primary_equipment")
  String? primaryEquipment;
  @JsonKey(name: "_primary_items")
  int? primaryItems;
  @JsonKey(name: "secondary_equipment")
  dynamic secondaryEquipment;
  @JsonKey(name: "_secondary_items")
  int? secondaryItems;
  @JsonKey(name: "posture")
  String? posture;
  @JsonKey(name: "single_or_double_arm")
  String? singleOrDoubleArm;
  @JsonKey(name: "continuous_or_alternating_arms")
  String? continuousOrAlternatingArms;
  @JsonKey(name: "grip")
  String? grip;
  @JsonKey(name: "load_position_ending")
  String? loadPositionEnding;
  @JsonKey(name: "continuous_or_alternating_legs")
  String? continuousOrAlternatingLegs;
  @JsonKey(name: "foot_elevation")
  String? footElevation;
  @JsonKey(name: "combination_exercises")
  String? combinationExercises;
  @JsonKey(name: "movement_pattern_1")
  String? movementPattern1;
  @JsonKey(name: "movement_pattern_2")
  String? movementPattern2;
  @JsonKey(name: "movement_pattern_3")
  dynamic movementPattern3;
  @JsonKey(name: "plane_of_motion_1")
  String? planeOfMotion1;
  @JsonKey(name: "plane_of_motion_2")
  dynamic planeOfMotion2;
  @JsonKey(name: "plane_of_motion_3")
  dynamic planeOfMotion3;
  @JsonKey(name: "body_region")
  String? bodyRegion;
  @JsonKey(name: "force_type")
  String? forceType;
  @JsonKey(name: "mechanics")
  String? mechanics;
  @JsonKey(name: "laterality")
  String? laterality;
  @JsonKey(name: "primary_exercise_classification")
  String? primaryExerciseClassification;
  @JsonKey(name: "short_youtube_demonstration_link")
  String? shortYoutubeDemonstrationLink;
  @JsonKey(name: "in_depth_youtube_explanation_link")
  String? inDepthYoutubeExplanationLink;

  Exercise({
    this.id,
    this.exercise,
    this.shortYoutubeDemonstration,
    this.inDepthYoutubeExplanation,
    this.difficultyLevel,
    this.targetMuscleGroup,
    this.primeMoverMuscle,
    this.secondaryMuscle,
    this.tertiaryMuscle,
    this.primaryEquipment,
    this.primaryItems,
    this.secondaryEquipment,
    this.secondaryItems,
    this.posture,
    this.singleOrDoubleArm,
    this.continuousOrAlternatingArms,
    this.grip,
    this.loadPositionEnding,
    this.continuousOrAlternatingLegs,
    this.footElevation,
    this.combinationExercises,
    this.movementPattern1,
    this.movementPattern2,
    this.movementPattern3,
    this.planeOfMotion1,
    this.planeOfMotion2,
    this.planeOfMotion3,
    this.bodyRegion,
    this.forceType,
    this.mechanics,
    this.laterality,
    this.primaryExerciseClassification,
    this.shortYoutubeDemonstrationLink,
    this.inDepthYoutubeExplanationLink,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  ExerciseEntity toEntity() => ExerciseEntity(
        id: id,
        exercise: exercise,
        shortYoutubeDemonstration: shortYoutubeDemonstration,
        inDepthYoutubeExplanation: inDepthYoutubeExplanation,
        difficultyLevel: difficultyLevel,
        targetMuscleGroup: targetMuscleGroup,
        primeMoverMuscle: primeMoverMuscle,
        secondaryMuscle: secondaryMuscle?.toString(),
        tertiaryMuscle: tertiaryMuscle?.toString(),
        primaryEquipment: primaryEquipment,
        primaryItems: primaryItems,
        secondaryEquipment: secondaryEquipment?.toString(),
        secondaryItems: secondaryItems,
        posture: posture,
        singleOrDoubleArm: singleOrDoubleArm,
        continuousOrAlternatingArms: continuousOrAlternatingArms,
        grip: grip,
        loadPositionEnding: loadPositionEnding,
        continuousOrAlternatingLegs: continuousOrAlternatingLegs,
        footElevation: footElevation,
        combinationExercises: combinationExercises,
        movementPattern1: movementPattern1,
        movementPattern2: movementPattern2,
        movementPattern3: movementPattern3?.toString(),
        planeOfMotion1: planeOfMotion1,
        planeOfMotion2: planeOfMotion2?.toString(),
        planeOfMotion3: planeOfMotion3?.toString(),
        bodyRegion: bodyRegion,
        forceType: forceType,
        mechanics: mechanics,
        laterality: laterality,
        primaryExerciseClassification: primaryExerciseClassification,
        shortYoutubeDemonstrationLink: shortYoutubeDemonstrationLink,
        inDepthYoutubeExplanationLink: inDepthYoutubeExplanationLink,
      );
}
