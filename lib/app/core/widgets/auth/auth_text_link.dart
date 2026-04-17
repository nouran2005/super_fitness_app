import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../ui_helper/color/colors.dart';
import '../../ui_helper/style/font_style.dart';

class AuthTextLink extends StatelessWidget {
  const AuthTextLink({
    super.key,
    required this.text,
    this.onTap,
    this.color = AppColors.primary,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.underlineThickness = 1.5,
    this.underlineOffset = 3.0,
    this.gapPadding = 1.9,
    this.nonDescenderLift = 1.3,
    this.letterSpacing = 0.15,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.centerLeft,
  });

  final String text;
  final VoidCallback? onTap;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double underlineThickness;
  final double underlineOffset;
  final double gapPadding;
  final double nonDescenderLift;
  final double letterSpacing;
  final EdgeInsetsGeometry padding;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppStyles.font14White.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    );

    final textDirection = Directionality.of(context);
    final textPainter = _createTextPainter(textStyle, textDirection);
    final textSize = textPainter.size;

    final linkChild = CustomPaint(
      size: textSize,
      painter: _AuthTextLinkPainter(
        text: text,
        style: textStyle,
        color: color,
        textDirection: textDirection,
        underlineThickness: underlineThickness,
        underlineOffset: underlineOffset,
        gapPadding: gapPadding,
        nonDescenderLift: nonDescenderLift,
      ),
    );

    final tappableChild = onTap == null
        ? linkChild
        : InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: linkChild,
          );

    return Align(
      alignment: alignment,
      child: Padding(padding: padding, child: tappableChild),
    );
  }

  TextPainter _createTextPainter(TextStyle style, TextDirection textDirection) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: textDirection,
      maxLines: 1,
    )..layout();
    return painter;
  }
}

class _AuthTextLinkPainter extends CustomPainter {
  const _AuthTextLinkPainter({
    required this.text,
    required this.style,
    required this.color,
    required this.textDirection,
    required this.underlineThickness,
    required this.underlineOffset,
    required this.gapPadding,
    required this.nonDescenderLift,
  });

  final String text;
  final TextStyle style;
  final Color color;
  final TextDirection textDirection;
  final double underlineThickness;
  final double underlineOffset;
  final double gapPadding;
  final double nonDescenderLift;

  static final RegExp _descenderPattern = RegExp(r'[g]');

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: textDirection,
      maxLines: 1,
    )..layout(maxWidth: size.width);

    _paintCharacters(canvas, textPainter);

    final metrics = textPainter.computeLineMetrics();
    if (metrics.isEmpty) return;

    final baseline = metrics.first.baseline;
    final underlineY = baseline + underlineOffset;
    final paint = Paint()
      ..color = color
      ..strokeWidth = underlineThickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final gaps = _collectUnderlineGaps(textPainter);
    var currentStart = 0.0;

    for (final gap in gaps) {
      final gapStart = math.max(0.0, gap.left - gapPadding).toDouble();
      final gapEnd = math.min(size.width, gap.right + gapPadding).toDouble();
      if (gapStart > currentStart) {
        canvas.drawLine(
          Offset(currentStart, underlineY),
          Offset(gapStart, underlineY),
          paint,
        );
      }
      currentStart = math.max(currentStart, gapEnd);
    }

    if (currentStart < size.width) {
      canvas.drawLine(
        Offset(currentStart, underlineY),
        Offset(size.width, underlineY),
        paint,
      );
    }
  }

  List<TextBox> _collectUnderlineGaps(TextPainter textPainter) {
    final gaps = <TextBox>[];

    for (var i = 0; i < text.length; i++) {
      if (!_descenderPattern.hasMatch(text[i])) continue;

      final selection = TextSelection(baseOffset: i, extentOffset: i + 1);
      gaps.addAll(textPainter.getBoxesForSelection(selection));
    }

    gaps.sort((a, b) => a.left.compareTo(b.left));
    return gaps;
  }

  void _paintCharacters(Canvas canvas, TextPainter textPainter) {
    for (var i = 0; i < text.length; i++) {
      final selection = TextSelection(baseOffset: i, extentOffset: i + 1);
      final boxes = textPainter.getBoxesForSelection(selection);
      if (boxes.isEmpty) continue;

      final characterPainter = TextPainter(
        text: TextSpan(text: text[i], style: style),
        textDirection: textDirection,
        maxLines: 1,
      )..layout();

      final lift = _descenderPattern.hasMatch(text[i]) ? 0.0 : nonDescenderLift;
      characterPainter.paint(canvas, Offset(boxes.first.left, -lift));
    }
  }

  @override
  bool shouldRepaint(covariant _AuthTextLinkPainter oldDelegate) {
    return oldDelegate.text != text ||
        oldDelegate.style != style ||
        oldDelegate.color != color ||
        oldDelegate.textDirection != textDirection ||
        oldDelegate.underlineThickness != underlineThickness ||
        oldDelegate.underlineOffset != underlineOffset ||
        oldDelegate.gapPadding != gapPadding ||
        oldDelegate.nonDescenderLift != nonDescenderLift;
  }
}
