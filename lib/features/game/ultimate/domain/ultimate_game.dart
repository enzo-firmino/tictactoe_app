import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/entities/winning_line.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';

part 'ultimate_game.freezed.dart';

@freezed
abstract class UltimateGame with _$UltimateGame {
  const factory UltimateGame({
    required List<Board> boards,
    WinningLine? winningLine,
    required Player currentPlayer,
    int? activeBoard,
    Player? winner,
    @Default(false) bool isVsAi,
  }) = _UltimateGame;

  factory UltimateGame.initial(bool isVsAi) {
    final Random random = Random();
    final Player currentPlayer = random.nextBool() ? Player.x : Player.o;

    return UltimateGame(boards: List<Board>.filled(9, Board.initial()), currentPlayer: currentPlayer, isVsAi: isVsAi);
  }

  factory UltimateGame.example() {
    return UltimateGame(
      boards: <Board>[
        Board.winningO(),
        Board.random(),
        Board.random(),
        Board.winningX(),
        Board.winningX(),
        Board.winningX(),
        Board.winningO(),
        Board.winningO(),
        Board.random(),
      ],
      winningLine: WinningLine(indices: <int>[3, 4, 5], player: Player.x),
      currentPlayer: Player.none,
    );
  }
}
