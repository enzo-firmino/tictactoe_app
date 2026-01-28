import 'package:flutter/material.dart';
import 'package:tictactoe_app/core/design_system/colors.dart';

enum Player { x, o, none }

extension PlayerExtension on Player {
  Color get color {
    switch (this) {
      case Player.x:
        return AppColors.red;
      case Player.o:
        return AppColors.primary;
      case Player.none:
        return AppColors.primaryDark;
    }
  }

  String get displayName {
    switch (this) {
      case .x:
        return 'X';
      case .o:
        return 'O';
      case .none:
        return '';
    }
  }

  Player get opponent {
    switch (this) {
      case Player.x:
        return Player.o;
      case Player.o:
        return Player.x;
      case Player.none:
        return Player.none;
    }
  }
}
