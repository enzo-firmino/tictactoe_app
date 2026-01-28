import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_app/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe_app/features/game/domain/enum/game_mode.dart';

part 'game_settings_provider.g.dart';

@Riverpod(keepAlive: true)
class GameSettingsNotifier extends _$GameSettingsNotifier {
  @override
  GameSettings build() {
    return GameSettings.initial();
  }

  void setGameMode(GameMode gameMode) {
    state = state.copyWith(gameMode: gameMode);
  }

  void setIsVsIa(bool isVsAi) {
    state = state.copyWith(isVsAi: isVsAi);
  }
}
