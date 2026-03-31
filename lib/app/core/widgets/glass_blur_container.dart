import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBlurContainer extends StatelessWidget {
  const GlassBlurContainer({
    super.key,
    required this.child,
    this.blurSigma = 34.6,
    this.borderRadius = const BorderRadius.all(Radius.circular(36)),
    this.padding = const EdgeInsets.all(24),
    this.margin,
    this.backgroundColor = const Color(0x1AFFFFFF),
    this.borderColor = const Color(0x40FFFFFF),
    this.shadowColor = const Color(0x40000000),
  });

  final Widget child;
  final double blurSigma;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 30,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
              border: Border.all(color: borderColor),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
