import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF58B8FE);
  static const Color primaryDark = Color(0xff00385e);
  static const Color secondary = Color(0xFFFFBE0B);
  static const Color red = Color(0xFFE63946);

  static ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: primary,
    brightness: Brightness.light,
  );

  static ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: primary,
    brightness: Brightness.dark,
  );
}
