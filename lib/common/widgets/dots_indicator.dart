import 'package:flutter/material.dart';

class DotsIndicator extends StatelessWidget {
  final int count;
  final int activeIndex;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;
  final double spacing;

  const DotsIndicator({
    super.key,
    required this.count,
    required this.activeIndex,
    this.activeColor,
    this.inactiveColor,
    this.size = 8,
    this.spacing = 6,
  });

  @override
  Widget build(BuildContext context) {
    final Color active = activeColor ?? Theme.of(context).colorScheme.primary;
    final Color inactive = inactiveColor ?? Colors.grey.shade300;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final bool isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: isActive ? size + 2 : size,
          height: isActive ? size + 2 : size,
          decoration: BoxDecoration(
            color: isActive ? active : inactive,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

