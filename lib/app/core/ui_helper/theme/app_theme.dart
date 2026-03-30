import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.blackColor,
      surface: AppColors.white,
      error: AppColors.error,
    ),

    ////////////////////////////////////////////AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.blackColor),
      titleTextStyle: TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),

    /////////////////////////////////////////////////////Inputs
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.disabled, fontSize: 14),
      labelStyle: TextStyle(color: AppColors.blackColor, fontSize: 16),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      filled: true,
      fillColor: AppColors.lightGrey,

      enabledBorder: _border(AppColors.lightGrey),
      focusedBorder: _border(AppColors.primary),
      errorBorder: _border(AppColors.error),
      focusedErrorBorder: _border(AppColors.error),
    ),

    ////////////////////////////////////////////////////Text
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
      headlineSmall: TextStyle(fontSize: 16, color: AppColors.grey),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.grey),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.blackColor,
      ),
      labelSmall: TextStyle(fontSize: 12, color: AppColors.disabled),
    ),

    ////////////////////////////////////////////////////Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    /////////////////////////////////////////////////Bottom Navigation
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.white,
      indicatorColor: AppColors.primary,
      elevation: 0,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.white);
        }
        return const IconThemeData(color: AppColors.grey);
      }),
    ),
  );

  static OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
