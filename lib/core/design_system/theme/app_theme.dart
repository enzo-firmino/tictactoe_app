import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe_app/core/design_system/theme/app_theme_color_data.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppThemeColorData.light().primary,
      onPrimary: Colors.white,
      secondary: AppThemeColorData.light().secondary,
      onSecondary: Colors.white,
      tertiary: AppThemeColorData.light().tertiary,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.white,
    ),
    textTheme: GoogleFonts.nunitoTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: AppThemeColorData.light().primary,
      displayColor: AppThemeColorData.light().primary,
    ),
    scaffoldBackgroundColor: AppThemeColorData.light().background,
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(
          backgroundColor: AppThemeColorData.light().background,
        ),
        TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(
          backgroundColor: AppThemeColorData.light().background,
        ),
      },
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      color: AppThemeColorData.light().neutral,
      selectedColor: Colors.white,
      fillColor: AppThemeColorData.light().secondary,
    ),
  );
}
