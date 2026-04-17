import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/ui_helper/style/font_style.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/onboarding/domain/models/onboarding_model.dart';
import 'package:super_fitness_app/features/onboarding/presentation/widgets/dots_animated_container.dart';
import 'package:super_fitness_app/features/onboarding/presentation/widgets/onboarding_button.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller = PageController();
  int currentIndex = 0;
  final List<OnboardingModel> pages = [
    OnboardingModel(
      title: LocaleKeys.titleOnboarding1.tr(),
      description: LocaleKeys.descriptionOnboarding.tr(),
      image: Assets.imagesOnboarding1,
    ),
    OnboardingModel(
      title: LocaleKeys.titleOnboarding2.tr(),
      description: LocaleKeys.descriptionOnboarding.tr(),
      image: Assets.imagesOnboarding2,
    ),
    OnboardingModel(
      title: LocaleKeys.titleOnboarding3.tr(),
      description: LocaleKeys.descriptionOnboarding.tr(),
      image: Assets.imagesOnboarding3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  SizedBox.expand(
                    child: Image.asset(
                      Assets.imagesOnboardingBackground,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox.expand(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(color: Colors.black.withOpacity(0.2)),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: height * 0.07),
                      Image.asset(
                        pages[index].image,
                        height: height * 0.6,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: GlassBlurContainer(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: height * 0.03,
                            horizontal: width * 0.05,
                          ),
                          blurSigma: 20,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          borderColor: Colors.transparent,
                          child: Column(
                            children: [
                              Text(
                                pages[index].title,
                                textAlign: TextAlign.center,
                                style: AppStyles.black24SemiBold.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                pages[index].description,
                                textAlign: TextAlign.center,
                                style: AppStyles.grey2_16Regular.copyWith(
                                  color: AppColors.white70,
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  pages.length,
                                  (index) => DotsAnimatedContainer(
                                    index: index,
                                    currentIndex: currentIndex,
                                  ),
                                ),
                              ),
                              Spacer(),
                              OnboardingButton(
                                pages: pages,
                                controller: controller,
                                currentIndex: currentIndex,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () => context.pushReplacement(RouteNames.login),
                  child: Text(
                    LocaleKeys.skip.tr(),
                    style: AppStyles.font14Black.copyWith(
                      color: AppColors.white70,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
