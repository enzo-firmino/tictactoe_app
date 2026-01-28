import 'package:tictactoe_app/features/game/domain/entities/winning_line.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';

class CheckWinningLineUseCase {
  WinningLine? call(List<Player> cells) {
    const int gridSize = 3;

    for (int row = 0; row < gridSize; row++) {
      final List<int> indices = _getRowIndices(row, gridSize);
      if (_checkLine(cells, indices)) {
        return WinningLine(indices: indices, player: cells[indices[0]]);
      }
    }

    for (int col = 0; col < gridSize; col++) {
      final List<int> indices = _getColumnIndices(col, gridSize);
      if (_checkLine(cells, indices)) {
        return WinningLine(indices: indices, player: cells[indices[0]]);
      }
    }

    final List<int> mainDiagonalIndices = _getMainDiagonalIndices(gridSize);
    if (_checkLine(cells, mainDiagonalIndices)) {
      return WinningLine(indices: mainDiagonalIndices, player: cells[mainDiagonalIndices[0]]);
    }

    final List<int> antiDiagonalIndices = _getAntiDiagonalIndices(gridSize);
    if (_checkLine(cells, antiDiagonalIndices)) {
      return WinningLine(indices: antiDiagonalIndices, player: cells[antiDiagonalIndices[0]]);
    }

    return null;
  }

  bool _checkLine(List<Player> board, List<int> indices) {
    final Player first = board[indices[0]];
    if (first == Player.none) return false;
    return indices.every((int index) => board[index] == first);
  }

  List<int> _getRowIndices(int row, int gridSize) {
    return List<int>.generate(gridSize, (int col) => row * gridSize + col);
  }

  List<int> _getColumnIndices(int col, int gridSize) {
    return List<int>.generate(gridSize, (int row) => row * gridSize + col);
  }

  List<int> _getMainDiagonalIndices(int gridSize) {
    return List<int>.generate(gridSize, (int i) => i * gridSize + i);
  }

  List<int> _getAntiDiagonalIndices(int gridSize) {
    return List<int>.generate(gridSize, (int i) => i * gridSize + (gridSize - 1 - i));
  }
}
