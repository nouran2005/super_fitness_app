import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_fitness_app/app/core/router/route_names.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';
import 'package:super_fitness_app/generated/locale_keys.g.dart';

class OnboardingButton extends StatefulWidget {
  OnboardingButton({
    super.key,
    required this.pages,
    required this.controller,
    required this.currentIndex,
  });
  final List pages;
  PageController controller;
  int currentIndex;

  @override
  State<OnboardingButton> createState() => _OnboardingButtonState();
}

class _OnboardingButtonState extends State<OnboardingButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return widget.currentIndex == 0
        ? SizedBox(
            width: double.infinity,
            height: height * 0.05,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                widget.controller.nextPage(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
                setState(() {});
              },
              child: Text(LocaleKeys.next.tr()),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width * 0.25,
                height: height * 0.05,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    widget.controller.previousPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                    setState(() {
                      widget.currentIndex--;
                    });
                  },
                  child: Text(
                    LocaleKeys.back.tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(
                width: width * 0.25,
                height: height * 0.05,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    if (widget.currentIndex == widget.pages.length - 1) {
                      context.pushReplacement(RouteNames.login);
                    } else {
                      widget.controller.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                      );
                      setState(() {});
                    }
                  },
                  child: Text(
                    widget.currentIndex == widget.pages.length - 1
                        ? LocaleKeys.doIt.tr()
                        : LocaleKeys.next.tr(),
                  ),
                ),
              ),
            ],
          );
  }
}
