import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe_app/features/game/domain/enum/game_mode.dart';

part 'game_settings.freezed.dart';

@freezed
abstract class GameSettings with _$GameSettings {
  const factory GameSettings({
    required GameMode gameMode,
    @Default(false) bool isVsAi,
  }) = _GameSettings;

  factory GameSettings.initial() {
    return const GameSettings(
      gameMode: GameMode.classic,
      isVsAi: false,
    );
  }
}
