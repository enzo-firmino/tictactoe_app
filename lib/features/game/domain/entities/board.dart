import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe_app/features/game/domain/entities/winning_line.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';

part 'board.freezed.dart';

@freezed
abstract class Board with _$Board {
  const factory Board({required List<Player> cells, WinningLine? winningLine}) = _Board;

  const Board._();

  factory Board.initial() {
    return Board(cells: List<Player>.filled(9, Player.none));
  }

  factory Board.winningO() {
    return Board(
      winningLine: WinningLine(indices: <int>[0, 4, 8], player: Player.o),
      cells: <Player>[
        Player.o,
        Player.x,
        Player.none,
        Player.none,
        Player.o,
        Player.x,
        Player.none,
        Player.x,
        Player.o,
      ],
    );
  }

  factory Board.winningX() {
    return Board(
      winningLine: WinningLine(indices: <int>[3, 4, 5], player: Player.x),
      cells: <Player>[
        Player.o,
        Player.none,
        Player.none,
        Player.x,
        Player.x,
        Player.x,
        Player.o,
        Player.x,
        Player.o,
      ],
    );
  }

  factory Board.random() {
    return Board(
      cells: <Player>[
        Player.none,
        Player.x,
        Player.o,
        Player.none,
        Player.o,
        Player.x,
        Player.none,
        Player.x,
        Player.o,
      ],
    );
  }

  bool get isFree => winningLine == null && cells.any((Player player) => player == Player.none);
  bool get isFull => cells.every((Player player) => player != Player.none);
}
