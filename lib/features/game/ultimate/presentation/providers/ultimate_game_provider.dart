import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe_app/features/game/domain/entities/winning_line.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';
import 'package:tictactoe_app/features/game/domain/usecases/ai_move_usecase.dart';
import 'package:tictactoe_app/features/game/domain/usecases/check_winning_line_usecase.dart';
import 'package:tictactoe_app/features/game/domain/usecases/make_move_usecase.dart';
import 'package:tictactoe_app/features/game/domain/usecases/validate_move_usecase.dart';
import 'package:tictactoe_app/features/game/presentation/providers/game_settings_provider.dart';
import 'package:tictactoe_app/features/game/presentation/providers/usecases_providers.dart';
import 'package:tictactoe_app/features/game/ultimate/domain/ultimate_game.dart';

part 'ultimate_game_provider.g.dart';

@riverpod
class UltimateGameNotifier extends _$UltimateGameNotifier {
  @override
  UltimateGame build() {
    final GameSettings settings = ref.read(gameSettingsProvider);
    return UltimateGame.initial(settings.isVsAi);
  }

  Future<void> playUltimateMove(int boardIndex, int index, [bool? isIaMove]) async {
    // Validate active board restriction
    if (state.activeBoard != null && boardIndex != state.activeBoard) return;

    final ValidateMoveUseCase validateMoveUseCase = ref.read(validateMoveUseCaseProvider);

    Board targetBoard = state.boards[boardIndex];
    if (!validateMoveUseCase.call(targetBoard, index)) return;

    final MakeMoveUseCase makeMoveUseCase = ref.read(makeMoveUseCaseProvider);
    final CheckWinningLineUseCase checkWinningLineUseCase = ref.read(checkWinningLineUseCaseProvider);
    final AiMoveUseCase aiMoveUseCase = ref.read(aiMoveUseCaseProvider);

    UltimateGame ultimateGame = state;

    Board newBoard = makeMoveUseCase.call(targetBoard, index, ultimateGame.currentPlayer);

    final WinningLine? winningLine = checkWinningLineUseCase.call(newBoard.cells);
    if (winningLine != null) {
      newBoard = newBoard.copyWith(winningLine: winningLine);
    }

    final List<Board> newBoards = List<Board>.from(ultimateGame.boards);
    newBoards[boardIndex] = newBoard;
    ultimateGame = ultimateGame.copyWith(boards: newBoards);

    final List<Player> metaBoardCells = ultimateGame.boards.map((Board board) {
      return board.winningLine?.player ?? Player.none;
    }).toList();
    final Board metaBoard = Board(cells: metaBoardCells);

    final WinningLine? metaWinningLine = checkWinningLineUseCase.call(metaBoard.cells);
    if (metaWinningLine != null) {
      state = ultimateGame.copyWith(winningLine: metaWinningLine, winner: metaWinningLine.player, activeBoard: null);
      return;
    }
    if (metaBoard.isFull) {
      state = ultimateGame.copyWith(winner: Player.none, activeBoard: null);
      return;
    }
    final Player nextPlayer = ultimateGame.currentPlayer.opponent;
    ultimateGame = ultimateGame.copyWith(currentPlayer: nextPlayer);
    if (ultimateGame.boards[index].winningLine == null &&
        ultimateGame.boards[index].cells.any((Player player) => player == Player.none)) {
      ultimateGame = ultimateGame.copyWith(activeBoard: index);
    } else {
      ultimateGame = ultimateGame.copyWith(activeBoard: null);
    }
    state = ultimateGame;
    if (ultimateGame.isVsAi && ultimateGame.winner == null && isIaMove != true) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 500));
      int indexBoard = state.activeBoard ?? state.boards.indexWhere((Board b) => b.isFree);
      final int? aiMove = aiMoveUseCase.call(state.boards[indexBoard], state.currentPlayer);
      if (aiMove != null) {
        await playUltimateMove(indexBoard, aiMove, true);
      }
    }
  }

  void reset() {
    state = UltimateGame.initial(state.isVsAi);
  }
}
