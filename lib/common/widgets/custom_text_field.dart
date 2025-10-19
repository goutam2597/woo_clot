import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/common/widgets/header_text.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final String? hintText;
  final IconData? icon;
  final bool? obscureText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  const CustomTextField({
    super.key,
    required this.text,
    this.icon,
    this.hintText,
    this.obscureText,
    this.controller,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(text: widget.text),
        SizedBox(height: 4),
        TextField(
          controller: widget.controller,
          obscureText: widget.obscureText ?? false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: IconButton(
              onPressed: widget.onTap,
              icon: Icon(widget.icon, size: 20, color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
