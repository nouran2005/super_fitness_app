import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';

class ExerciseHeader extends StatelessWidget {
  final String? imageUrl;
  final String title;

  const ExerciseHeader({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Container(
            height: size.height * 0.45,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.black),
            child: Stack(
              children: [
                Positioned.fill(
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            Assets.imagesExerciseBackground,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          Assets.imagesExerciseBackground,
                          fit: BoxFit.cover,
                        ),
                ),
                // Overlay Gradient
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Title Overlay
        Positioned(
          bottom: size.height * 0.05,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyles.font30WhiteSemiBold.copyWith(
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Back Button
        Positioned(
          top: padding.top + 10,
          left: 20,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: size.width * 0.045,
              child: Image.asset(
                Assets.imagesArrowBack,
                color: AppColors.white,
                width: size.width * 0.045,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
