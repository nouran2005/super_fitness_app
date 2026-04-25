import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_cubit.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_intent.dart';
import 'package:super_fitness_app/features/Exercise/presentation/manger/exercise_states.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_category_tabs.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_header.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_list_view.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/exercise_stats_row.dart';
import 'package:super_fitness_app/features/Exercise/presentation/view/widgets/video_overlay.dart';

class ExerciseBody extends StatefulWidget {
  const ExerciseBody({super.key});

  @override
  State<ExerciseBody> createState() => _ExerciseBodyState();
}

class _ExerciseBodyState extends State<ExerciseBody> {
  int _selectedCategoryIndex = 0;
  String? _selectedHeaderImageUrl;
  String? _selectedHeaderTitle;
  String? _selectedVideoUrl;
  bool _showVideoFrame = false;

  @override
  void initState() {
    super.initState();
    context.read<ExerciseCubit>().doIntent(const GetExercisesIntent());
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
          
          BlocBuilder<ExerciseCubit, ExerciseStates>(
            builder: (context, state) {
              if (state.exerciseResource.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.exerciseResource.isError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      state.exerciseResource.error ?? 'Error',
                      textAlign: TextAlign.center,
                      style: AppStyles.font14White,
                    ),
                  ),
                );
              }

              if (state.exerciseResource.isSuccess) {
                final data = state.exerciseResource.data!;
                final categories = data.categories ?? [];
                final selectedCategory =
                    categories.isNotEmpty ? categories[_selectedCategoryIndex] : null;
                final exercises = selectedCategory?.exercises ?? [];

                if (_selectedHeaderTitle == null && exercises.isNotEmpty) {
                  _selectedHeaderTitle = exercises.first.exercise;
                  _selectedHeaderImageUrl = _getYoutubeThumbnail(
                    exercises.first.shortYoutubeDemonstrationLink ?? '',
                    highRes: true,
                  );
                  _selectedVideoUrl = exercises.first.shortYoutubeDemonstrationLink;
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ExerciseHeader(
                        imageUrl: _selectedHeaderImageUrl,
                        title: _selectedHeaderTitle ?? 'Exercise',
                      ),
                      const ExerciseStatsRow(),
                      ExerciseCategoryTabs(
                        categories: categories,
                        selectedCategoryIndex: _selectedCategoryIndex,
                        onCategorySelected: (index) {
                          setState(() {
                            _selectedCategoryIndex = index;
                            _showVideoFrame = false;
                            final newExercises = categories[index].exercises;
                            if (newExercises.isNotEmpty) {
                              _selectedHeaderTitle = newExercises.first.exercise;
                              _selectedHeaderImageUrl = _getYoutubeThumbnail(
                                newExercises.first.shortYoutubeDemonstrationLink ?? '',
                                highRes: true,
                              );
                              _selectedVideoUrl = newExercises.first.shortYoutubeDemonstrationLink;
                            }
                          });
                        },
                      ),
                      ExerciseListView(
                        exercises: exercises,
                        getYoutubeThumbnail: (url) => _getYoutubeThumbnail(url, highRes: false),
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
              }

              return const SizedBox();
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