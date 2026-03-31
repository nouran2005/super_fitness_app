import 'package:flutter/material.dart';
import 'package:super_fitness_app/app/core/ui_helper/color/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.blackColor,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primary,
      secondary: AppColors.primary,
      onSecondary: AppColors.white,
      surface: const Color(0xFF1C1C1C),
      onSurface: AppColors.white,
      error: AppColors.error,
    ),

    ////////////////////////////////////////////AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
    ),

    /////////////////////////////////////////////////////Inputs
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Color(0xB3FFFFFF), fontSize: 16),
      labelStyle: const TextStyle(color: Color(0xB3FFFFFF), fontSize: 16),
      floatingLabelStyle: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      filled: true,
      fillColor: const Color(0x14FFFFFF),

      border: _border(const Color(0xCCFFFFFF)),
      enabledBorder: _border(const Color(0xCCFFFFFF)),
      focusedBorder: _border(AppColors.white),
      errorBorder: _border(AppColors.error),
      focusedErrorBorder: _border(AppColors.error),
      disabledBorder: _border(const Color(0x4DFFFFFF)),

      prefixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) return AppColors.white;
        return AppColors.white;
      }),
      suffixIconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) return AppColors.white;
        return AppColors.white;
      }),
    ),

    ////////////////////////////////////////////////////Text
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      headlineSmall: TextStyle(fontSize: 16, color: AppColors.disabled),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.white),
      labelLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      labelSmall: TextStyle(fontSize: 14, color: AppColors.disabled),
    ),

    ////////////////////////////////////////////////////Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        minimumSize: const Size(double.infinity, 56),
        shape: const StadiumBorder(),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.white,
        side: const BorderSide(color: AppColors.disabled),
        minimumSize: const Size(double.infinity, 56),
        shape: const StadiumBorder(),
      ),
    ),

    /////////////////////////////////////////////////Bottom Navigation
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      indicatorColor: Colors.transparent,
      elevation: 0,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          );
        }
        return const TextStyle(color: Colors.transparent);
      }),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary, size: 30);
        }
        return const IconThemeData(color: AppColors.white, size: 28);
      }),
    ),
  );

  static OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
