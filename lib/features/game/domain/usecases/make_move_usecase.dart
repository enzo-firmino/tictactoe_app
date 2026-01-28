import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';

class MakeMoveUseCase {
  Board call(Board board, int index, Player currentPlayer) {
    if (index < 0 || index >= board.cells.length) {
      return board;
    }
    if (board.cells[index] != Player.none) {
      return board;
    }
    final List<Player> newCells = List<Player>.from(board.cells);
    newCells[index] = currentPlayer;
    return board.copyWith(cells: newCells);
  }
}
