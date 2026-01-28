import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';

part 'classic_game.freezed.dart';

@freezed
abstract class ClassicGame with _$ClassicGame {
  const factory ClassicGame({
    required Board board,
    required Player currentPlayer,
    Player? winner,
    @Default(false) bool isVsAi,
  }) = _ClassicGame;

  factory ClassicGame.initial(bool isVsAi) {
    final Random random = Random();
    final Player currentPlayer = random.nextBool() ? Player.x : Player.o;
    return ClassicGame(
      board: Board.initial(),
      currentPlayer: currentPlayer,
      isVsAi: isVsAi,
    );
  }
}
