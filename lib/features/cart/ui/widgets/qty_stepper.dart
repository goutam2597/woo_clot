
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';

class QtyStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  const QtyStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.themeColor;
    final text = quantity.toString().padLeft(2, '0');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _circle(accent, Icons.remove, onDecrement),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        _circle(accent, Icons.add, onIncrement),
      ],
    );
  }

  Widget _circle(Color color, IconData icon, VoidCallback onTap) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(icon, color: Colors.white, size: 16),
        ),
      ),
    );
  }
}
