import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_cubit.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_intent.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_states.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_category_tabs.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_header.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_list_view.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_stats_row.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/video_overlay.dart';

class ExerciseBody extends StatefulWidget {
  final String muscleGroupId;
  final String? initialExerciseId;
  final String? initialDifficultyLevel;

  const ExerciseBody({
    super.key,
    required this.muscleGroupId,
    this.initialExerciseId,
    this.initialDifficultyLevel,
  });

  @override
  State<ExerciseBody> createState() => _ExerciseBodyState();
}

class _ExerciseBodyState extends State<ExerciseBody> {
  int _selectedCategoryIndex = 0;
  String? _selectedHeaderImageUrl;
  String? _selectedHeaderTitle;
  String? _selectedVideoUrl;
  bool _showVideoFrame = false;

  final List<Map<String, String>> _difficultyLevels = [
    {"id": "69d982ed85f6bfa972bf2216", "name": "Beginner"},
    {"id": "69d982ed85f6bfa972bf221c", "name": "Intermediate"},
    {"id": "69d982ed85f6bfa972bf221e", "name": "Novice"},
    {"id": "69d982ed85f6bfa972bf2222", "name": "Advanced"},
    {"id": "69d982ee85f6bfa972bf2228", "name": "Expert"},
    {"id": "69d982ee85f6bfa972bf223a", "name": "Grand Master"},
    {"id": "69d982ef85f6bfa972bf223c", "name": "Master"},
    {"id": "69d982ef85f6bfa972bf2242", "name": "Legendary"},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialDifficultyLevel != null) {
      final index = _difficultyLevels.indexWhere(
        (l) =>
            l["name"]!.toLowerCase() ==
            widget.initialDifficultyLevel!.toLowerCase(),
      );
      if (index != -1) {
        _selectedCategoryIndex = index;
      }
    }
    _fetchExercises();
  }

  void _fetchExercises() {
    context.read<ExerciseCubit>().doIntent(
      GetExercisesRandomIntent(
        muscleGroupId: widget.muscleGroupId,
        difficultyId: _difficultyLevels[_selectedCategoryIndex]["id"]!,
      ),
    );
  }

  String _getYoutubeThumbnail(String url, {bool highRes = false}) {
    final uri = Uri.tryParse(url);
    if (uri == null) return '';
    String? videoId;
    if (uri.host == 'youtu.be') {
      videoId = uri.pathSegments.first;
    } else if (uri.host.contains('youtube.com')) {
      videoId = uri.queryParameters['v'];
    }
    if (videoId == null) return '';
    return highRes 
      ? 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg'
      : 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.imagesHomeBackground,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          
          BlocConsumer<ExerciseCubit, ExerciseStates>(
            listener: (context, state) {
              if (state.currentExercisesResource.isSuccess) {
                final exercises = state.currentExercisesResource.data!;
                if (exercises.isNotEmpty) {
                  ExerciseEntity? selectedExercise;
                  if (widget.initialExerciseId != null) {
                    selectedExercise = exercises.firstWhere(
                      (e) => e.id == widget.initialExerciseId,
                      orElse: () => exercises.first,
                    );
                  } else {
                    selectedExercise = exercises.first;
                  }

                  setState(() {
                    _selectedHeaderTitle = selectedExercise!.exercise;
                    _selectedHeaderImageUrl = _getYoutubeThumbnail(
                      selectedExercise.shortYoutubeDemonstrationLink ?? '',
                      highRes: true,
                    );
                    _selectedVideoUrl =
                        selectedExercise.shortYoutubeDemonstrationLink;
                    if (widget.initialExerciseId != null &&
                        selectedExercise.id == widget.initialExerciseId) {
                      _showVideoFrame = true;
                    }
                  });
                }
              }
            },
            builder: (context, state) {
              final exercises = state.currentExercisesResource.data ?? [];
              final isLoading = state.currentExercisesResource.isLoading;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ExerciseHeader(
                      imageUrl: _selectedHeaderImageUrl,
                      title: _selectedHeaderTitle ?? 'Exercise',
                    ),
                    const ExerciseStatsRow(),
                    
                    ExerciseCategoryTabs(
                      categories: _difficultyLevels.map((l) => ExerciseCategoryEntity(name: l["name"]!, exercises: [])).toList(),
                      selectedCategoryIndex: _selectedCategoryIndex,
                      onCategorySelected: (index) {
                        setState(() {
                          _selectedCategoryIndex = index;
                          _showVideoFrame = false;
                        });
                        _fetchExercises();
                      },
                    ),

                    if (isLoading)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 50),
                        child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
                      )
                    else if (exercises.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Center(
                          child: Text(
                            'No exercises found for this level',
                            style: AppStyles.font14White,
                          ),
                        ),
                      )
                    else
                      ExerciseListView(
                        exercises: exercises,
                        getYoutubeThumbnail: (url) =>
                            _getYoutubeThumbnail(url, highRes: false),
                        onExerciseSelected: (exercise) {
                          setState(() {
                            _selectedHeaderImageUrl = _getYoutubeThumbnail(
                              exercise.shortYoutubeDemonstrationLink ?? '',
                              highRes: true,
                            );
                            _selectedHeaderTitle = exercise.exercise;
                            _selectedVideoUrl = exercise.shortYoutubeDemonstrationLink;
                            _showVideoFrame = true;
                          });
                        },
                      ),
                    SizedBox(height: size.height * 0.1),
                  ],
                ),
              );
            },
          ),

          if (_showVideoFrame && _selectedVideoUrl != null)
            VideoOverlay(
              videoUrl: _selectedVideoUrl!,
              title: _selectedHeaderTitle ?? '',
              onClose: () => setState(() => _showVideoFrame = false),
            ),
        ],
      ),
    );
  }
}