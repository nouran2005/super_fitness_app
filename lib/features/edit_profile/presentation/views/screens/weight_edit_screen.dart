import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/ui_helper/assets/app_images.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/app/core/widgets/glass_blur_container.dart';
import 'package:super_fitness_app/features/forget_password/presentation/views/widgets/app_logo_widget.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';
import 'package:super_fitness_app/features/auth/presentation/register/view/widgets/custom_wheel_picker.dart';

class WeightEditScreen extends StatefulWidget {
  final int initialWeight;
  const WeightEditScreen({super.key, required this.initialWeight});

  @override
  State<WeightEditScreen> createState() => _WeightEditScreenState();
}

class _WeightEditScreenState extends State<WeightEditScreen> {
  static const int _minWeight = 30;
  static const int _maxWeight = 200;

  late int _selected;
  late List<int> _weightItems;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialWeight;
    _weightItems = List.generate(
      _maxWeight - _minWeight + 1,
      (index) => _minWeight + index,
    );
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
                      LocaleKeys.whatIsYourWeight.tr().toUpperCase(),
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
              SizedBox(height: size.height * 0.09),
              GlassBlurContainer(
                backgroundColor: AppColors.white.withValues(alpha: 0.03),
                blurSigma: 8,
                borderColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    HorizontalWheelPicker(
                      items: _weightItems,
                      initialValue: _selected,
                      label: LocaleKeys.kg.tr(),
                      selectedFontSize: 38,
                      unselectedFontSize: 20,
                      viewportFraction: 0.22,
                      onChanged: (val) {
                        setState(() {
                          _selected = val;
                        });
                      },
                    ),
                    SizedBox(height: size.height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.050,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pop(_selected);
                        },
                        child: Text(LocaleKeys.done.tr()),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
