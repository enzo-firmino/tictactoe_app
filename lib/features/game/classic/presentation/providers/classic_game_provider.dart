import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_app/features/game/classic/domain/classic_game.dart';
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

part 'classic_game_provider.g.dart';

@riverpod
class ClassicGameNotifier extends _$ClassicGameNotifier {
  @override
  ClassicGame build() {
    final GameSettings settings = ref.read(gameSettingsProvider);
    return ClassicGame.initial(settings.isVsAi);
  }

  Future<void> playClassicMove(int index, [bool? isIaMove]) async {
    final ValidateMoveUseCase validateMoveUseCase = ref.read(validateMoveUseCaseProvider);
    if (!validateMoveUseCase.call(state.board, index)) return;

    final MakeMoveUseCase makeMoveUseCase = ref.read(makeMoveUseCaseProvider);
    final CheckWinningLineUseCase checkWinningLineUseCase = ref.read(checkWinningLineUseCaseProvider);
    final AiMoveUseCase aiMoveUseCase = ref.read(aiMoveUseCaseProvider);

    ClassicGame game = state;
    Board board = game.board;

    Board newBoard = makeMoveUseCase.call(board, index, game.currentPlayer);
    game = game.copyWith(board: newBoard);
    final WinningLine? winningLine = checkWinningLineUseCase.call(newBoard.cells);
    if (winningLine != null) {
      newBoard = newBoard.copyWith(winningLine: winningLine);
      state = game.copyWith(board: newBoard, winner: winningLine.player);
      return;
    }
    if (game.board.isFull) {
      state = game.copyWith(winner: Player.none);
      return;
    }
    state = game.copyWith(currentPlayer: game.currentPlayer.opponent);

    if (game.isVsAi && game.winner == null && isIaMove != true) {
      await Future<dynamic>.delayed(const Duration(milliseconds: 500));
      final int? aiMove = aiMoveUseCase.call(game.board, game.currentPlayer);
      if (aiMove != null) {
        await playClassicMove(aiMove, true);
      }
    }
  }

  void reset() {
    state = ClassicGame.initial(state.isVsAi);
  }
}
