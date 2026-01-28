import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';

class ValidateMoveUseCase {
  bool call(Board board, int index) {
    if (index < 0 || index >= board.cells.length) {
      return false;
    }
    if (board.cells[index] != Player.none) {
      return false;
    }
    if (board.winningLine != null) {
      return false;
    }
    return true;
  }
}
