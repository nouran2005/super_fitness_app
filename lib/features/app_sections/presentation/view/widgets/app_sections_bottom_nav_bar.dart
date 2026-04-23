import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/features/app_sections/presentation/model/app_section_destination.dart';

class AppSectionsBottomNavBar extends StatelessWidget {
  const AppSectionsBottomNavBar({
    super.key,
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final List<AppSectionDestination> destinations;
  final int? currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF232323),
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.34),
              blurRadius: 28,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Row(
          children: List.generate(
            destinations.length,
            (index) => Expanded(
              child: AppSectionsNavItem(
                destination: destinations[index],
                isSelected: currentIndex == index,
                onTap: () => onDestinationSelected(index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppSectionsNavItem extends StatelessWidget {
  const AppSectionsNavItem({
    super.key,
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final AppSectionDestination destination;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          height: 70,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: isSelected ? 1 : 0),
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              final iconColor = Color.lerp(
                AppColors.white,
                AppColors.primary,
                value,
              )!;
              final iconOffsetY = -6 * value;
              final textOffsetY = 8 * (1 - value);
              final textScale = 0.92 + (0.08 * value);

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(0, iconOffsetY),
                    child: Transform.scale(
                      scale: 1 + (0.05 * value),
                      child: SvgPicture.asset(
                        destination.iconPath,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          iconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  if (value > 0)
                    ClipRect(
                      child: Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, textOffsetY),
                          child: Transform.scale(
                            scale: textScale,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                destination.label,
                                style: AppStyles.black24SemiBold.copyWith(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
