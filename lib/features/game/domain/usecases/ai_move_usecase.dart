import 'dart:math';

import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';

class AiMoveUseCase {
  int? call(Board board, Player aiPlayer) {
    final Player humanPlayer = aiPlayer == Player.x ? Player.o : Player.x;
    const int gridSize = 3;

    final int? winningMove = _findWinningMove(board.cells, aiPlayer, gridSize);
    if (winningMove != null) return winningMove;

    final int? blockingMove = _findWinningMove(board.cells, humanPlayer, gridSize);
    if (blockingMove != null) return blockingMove;

    final List<int> emptyCells = <int>[];
    for (int i = 0; i < board.cells.length; i++) {
      if (board.cells[i] == Player.none) {
        emptyCells.add(i);
      }
    }

    if (emptyCells.isEmpty) return null;

    final Random random = Random();
    return emptyCells[random.nextInt(emptyCells.length)];
  }

  int? _findWinningMove(List<Player> board, Player player, int gridSize) {
    for (int row = 0; row < gridSize; row++) {
      final int? move = _checkLine(board, player, _getRowIndices(row, gridSize));
      if (move != null) return move;
    }

    for (int col = 0; col < gridSize; col++) {
      final int? move = _checkLine(board, player, _getColumnIndices(col, gridSize));
      if (move != null) return move;
    }

    final int? mainDiagMove = _checkLine(board, player, _getMainDiagonalIndices(gridSize));
    if (mainDiagMove != null) return mainDiagMove;

    final int? antiDiagMove = _checkLine(board, player, _getAntiDiagonalIndices(gridSize));
    if (antiDiagMove != null) return antiDiagMove;

    return null;
  }

  int? _checkLine(List<Player> board, Player player, List<int> indices) {
    int playerCount = 0;
    int emptyIndex = -1;

    for (final int index in indices) {
      if (board[index] == player) {
        playerCount++;
      } else if (board[index] == Player.none) {
        emptyIndex = index;
      }
    }

    if (playerCount == indices.length - 1 && emptyIndex != -1) {
      return emptyIndex;
    }

    return null;
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
