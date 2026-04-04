import 'package:flutter/material.dart';

class BulerContainer extends StatelessWidget {
  final Widget child;
  final double? horizontalPadding;
  final double? verticalPadding;

  const BulerContainer({
    super.key,
    required this.child,
    this.horizontalPadding,
    this.verticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? (mq.size.width * 0.04),
        vertical: verticalPadding ?? (mq.size.height * 0.03),
      ),
      decoration: BoxDecoration(
        color: Colors.white38.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(mq.size.width * 0.13),
      ),
      child: child,
    );
  }
}
