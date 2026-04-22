import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/features/app_sections/presentation/model/app_section_destination.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/widgets/app_section_placeholder.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view/widgets/app_sections_bottom_nav_bar.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_cubit.dart';
import 'package:super_fitness_app/features/work_out/presentation/view/pages/work_out_page.dart';
import 'package:super_fitness_app/features/app_sections/presentation/view_model/cubit/app_sections_state.dart';

class AppSectionsView extends StatelessWidget {
  const AppSectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSectionsCubit, AppSectionsState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: state.currentIndex,
            children: [
              AppSectionPlaceholder(
                title: appSectionDestinations[0].title,
                subtitle: appSectionDestinations[0].subtitle,
              ),
              AppSectionPlaceholder(
                title: appSectionDestinations[1].title,
                subtitle: appSectionDestinations[1].subtitle,
              ),
              const WorkOutPage(),
              AppSectionPlaceholder(
                title: appSectionDestinations[3].title,
                subtitle: appSectionDestinations[3].subtitle,
              ),
            ],
          ),
          bottomNavigationBar: AppSectionsBottomNavBar(
            destinations: appSectionDestinations,
            currentIndex: state.currentIndex,
            onDestinationSelected: (index) =>
                context.read<AppSectionsCubit>().changePage(index),
          ),
        );
      },
    );
  }
}
