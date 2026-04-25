import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/widgets/section_header.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/app_Par.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/categorySection.dart';
import 'package:super_fitness_app/features/home/presentation/widgets/recommendation_section.dart';
import 'package:super_fitness_app/features/popular_training/presentation/views/widgets/popular_training_list.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscle_group_sections.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/widgets/muscles_horizontal_list.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/sections background.png',
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
            ),
            // Content
            SafeArea(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height - MediaQuery.of(context).padding.top,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      CustomAppBar(
                        userName: 'Ahmed',
                        photoAsset: 'assets/images/prfofle photo .png',
                      ),
                      const SizedBox(height: 8),
                      const CategorySection(),
                      const SizedBox(height: 24),
                      RecommendationSection(
                        title: LocaleKeys.recommendationToDay.tr(),
                        showSeeAll: false,
                      ),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: LocaleKeys.upcomingWorkouts.tr(),
                        onSeeAllTap: () {
                          context.read<AppSectionsCubit>().changePage(2);
                        },
                      ),
                      const SizedBox(height: 12),
                      const MuscleGroupSections(),
                      const SizedBox(height: 16),
                      const MusclesHorizontalList(),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: LocaleKeys.recommendationForYou.tr(),
                        onSeeAllTap: () {},
                      ),
                      const SizedBox(height: 24),
                      PopularTrainingList(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
