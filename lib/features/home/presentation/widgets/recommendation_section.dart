import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_cubit.dart';
import 'package:super_fitness_app/features/home/presentation/manger/Rc_to_day_states.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/recommendation_item.dart';
import 'package:super_fitness_app/app/core/widgets/section_header.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({
    super.key,
    required this.title,
    this.showSeeAll = true,
  });

  final String title;
  final bool showSeeAll;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          showSeeAll: showSeeAll,
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: screenWidth * 0.27,
          child: BlocBuilder<RcToDayCubit, RcToDayStates>(
            builder: (context, state) {
              final resource = state.recommendationResource;

              if (resource.isLoading) {
                return const Center(child: CircularProgressIndicator(color: Colors.orange));
              }

              if (resource.isError) {
                return Center(
                  child: Text(
                    resource.error ?? 'Error',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (resource.isSuccess && resource.data != null) {
                final muscles = resource.data!.muscles ?? [];
                
                final randomMuscles = (List.of(muscles)..shuffle()).take(3).toList();
                
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Row(
                    children: randomMuscles.map((muscle) {
                      return Expanded(
                        child: RecommendationItem(
                          imagePath: muscle.image ?? '',
                          label: muscle.name ?? '',
                          isNetworkImage: true,
                        ),
                      );
                    }).toList(),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
