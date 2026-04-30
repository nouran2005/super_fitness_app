import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/Exercise/domain/model/exercise_entity.dart';

class ExerciseCategoryTabs extends StatefulWidget {
  final List<ExerciseCategoryEntity> categories;
  final int selectedCategoryIndex;
  final Function(int) onCategorySelected;

  const ExerciseCategoryTabs({
    super.key,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
  });

  @override
  State<ExerciseCategoryTabs> createState() => _ExerciseCategoryTabsState();
}

class _ExerciseCategoryTabsState extends State<ExerciseCategoryTabs> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
    });
  }

  @override
  void didUpdateWidget(ExerciseCategoryTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategoryIndex != widget.selectedCategoryIndex) {
      _scrollToSelected();
    }
  }

  void _scrollToSelected() {
    if (_scrollController.hasClients) {
      final screenWidth = MediaQuery.of(context).size.width;
      final tabWidth = screenWidth * 0.25;
      final targetOffset =
          (widget.selectedCategoryIndex * tabWidth) -
          (screenWidth / 2) +
          (tabWidth / 2);

      _scrollController.animateTo(
        targetOffset.clamp(0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 55, // Reduced height
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final isSelected = widget.selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => widget.onCategorySelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                widget.categories[index].name,
                style: AppStyles.font14White.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.white60,
                  fontSize: size.width * 0.03, // Reduced from 0.038
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
