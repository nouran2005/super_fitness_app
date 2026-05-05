import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_cubit.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_intent.dart';
import 'package:super_fitness_app/features/meals/presentation/view_model/cubit/meals_states.dart';

class CategoriesTabBar extends StatefulWidget {
  const CategoriesTabBar({super.key});

  @override
  State<CategoriesTabBar> createState() => _CategoriesTabBarState();
}

class _CategoriesTabBarState extends State<CategoriesTabBar>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MealsCubit>(context);
    return BlocBuilder<MealsCubit, MealsStates>(
      builder: (context, state) {
        final categories = state.mealsCategoriesResource.data?.categories ?? [];
        if (_tabController == null ||
            _tabController!.length != categories.length) {
          _tabController?.dispose();
          _tabController = TabController(
            length: categories.length,
            vsync: this,
            initialIndex: state.selectedIndex,
          );

          _tabController!.addListener(() {
            if (!_tabController!.indexIsChanging) {
              cubit.doIntent(
                SelectCategoryEvent(selectedIndex: _tabController!.index),
              );
            }
          });
        }

        return TabBar(
          tabAlignment: TabAlignment.start,
          controller: _tabController,
          isScrollable: true,
          labelPadding: EdgeInsets.only(right: 16),
          splashFactory: NoSplash.splashFactory,
          indicator: const BoxDecoration(),
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.white70,
          dividerColor: Colors.transparent,
          tabs: List.generate(categories.length, (index) {
            final isSelected = index == state.selectedIndex;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    categories[index]?.strCategory ?? '',
                    style: AppStyles.font12BlackBold.copyWith(
                      color: isSelected ? AppColors.white : AppColors.white70,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
