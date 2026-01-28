import 'package:flutter/material.dart';
import 'package:tictactoe_app/core/design_system/colors.dart';

class AppThemeColorData {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color background;
  final Color neutral;

  const AppThemeColorData({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.background,
    required this.neutral,
  });

  factory AppThemeColorData.light() {
    return AppThemeColorData(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.red,
      background: Colors.white,
      neutral: const Color(0xFF9E9E9E),
    );
  }
}
