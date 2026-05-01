import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/widgets/app_logo_widget.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:super_fitness_app/app/core/values/activity_levels.dart';
import '../widgets/custom_radio_selection_tile.dart';

class ActivityEditScreen extends StatefulWidget {
  final String selectedActivity;

  const ActivityEditScreen({super.key, required this.selectedActivity});

  @override
  State<ActivityEditScreen> createState() => _ActivityEditScreenState();
}

class _ActivityEditScreenState extends State<ActivityEditScreen> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = ActivityLevels.backendLevels.contains(widget.selectedActivity)
        ? widget.selectedActivity
        : 'level1';
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
                child: Align(
                  alignment: Alignment.center,
                  child: AppLogoWidget(),
                ),
              ),
              SizedBox(height: size.height * 0.12),
              Padding(
                padding: EdgeInsetsDirectional.only(start: horizontalPadding),
                child: Text(
                  LocaleKeys.activityLevelQuestionTitle.tr(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: size.width * 0.058,
                    letterSpacing: 0.4,
                    height: 1.25,
                  ),
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
                      itemCount: ActivityLevels.backendLevels.length,
                      itemBuilder: (_, index) {
                        final backendLevel =
                            ActivityLevels.backendLevels[index];
                        final displayLevel = ActivityLevels.getDisplayLevel(
                          backendLevel,
                        );
                        return CustomRadioSelectionTile(
                          label: displayLevel,
                          isSelected: _selected == backendLevel,
                          onTap: () => setState(() => _selected = backendLevel),
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
