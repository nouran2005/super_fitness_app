import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/widgets/app_logo_widget.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:super_fitness_app/app/core/values/fitness_goals.dart';
import '../widgets/custom_radio_selection_tile.dart';

class GoalEditScreen extends StatefulWidget {
  final String selectedGoal;

  const GoalEditScreen({super.key, required this.selectedGoal});

  @override
  State<GoalEditScreen> createState() => _GoalEditScreenState();
}

class _GoalEditScreenState extends State<GoalEditScreen> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = FitnessGoals.backendGoals.contains(widget.selectedGoal)
        ? widget.selectedGoal
        : FitnessGoals.backendGoals.first;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.06;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.imagesAuthBackground2),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: const Align(
                  alignment: Alignment.center,
                  child: AppLogoWidget(),
                ),
              ),
              SizedBox(height: size.height * 0.12),
              Padding(
                padding: EdgeInsetsDirectional.only(start: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.whatIsYourGoal.tr().toUpperCase(),
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontSize: size.width * 0.062,
                            letterSpacing: 0.4,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      LocaleKeys.personalizedPlanMsg.tr(),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GlassBlurContainer(
                backgroundColor: AppColors.white.withValues(alpha: 0.03),
                blurSigma: 8,
                borderColor: Colors.transparent,
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: FitnessGoals.backendGoals.length,
                      itemBuilder: (_, index) {
                        final backendGoal = FitnessGoals.backendGoals[index];
                        final displayGoal = FitnessGoals.getDisplayGoal(
                          backendGoal,
                        );
                        return CustomRadioSelectionTile(
                          label: displayGoal,
                          isSelected: _selected == backendGoal,
                          onTap: () => setState(() => _selected = backendGoal),
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.055,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pop(_selected);
                        },
                        child: Text(LocaleKeys.done.tr()),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
