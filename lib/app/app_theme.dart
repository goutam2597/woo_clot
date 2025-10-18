import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'CircularStd',
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.themeColor),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      hintStyle: TextStyle(
        color: Colors.grey.shade800,
        fontWeight: FontWeight.w600,
        fontSize: 14
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    ),

    appBarTheme: AppBarTheme(
      elevation: 1,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white.withAlpha(10),
      shadowColor: Colors.grey.shade50.withAlpha(100),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ),
  );
}
