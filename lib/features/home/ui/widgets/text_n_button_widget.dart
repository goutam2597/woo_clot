import 'package:flutter/material.dart';

class TextNButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const TextNButtonWidget({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          TextButton(
            onPressed: onTap,
            child: Text(
              'See All',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
