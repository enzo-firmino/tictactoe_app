import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/entities/winning_line.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';
import 'package:tictactoe_app/features/game/domain/usecases/validate_move_usecase.dart';

void main() {
  late ValidateMoveUseCase useCase;

  setUp(() {
    useCase = ValidateMoveUseCase();
  });

  group('ValidateMoveUseCase', () {
    test('should return true for valid move on empty cell', () {
      final Board board = Board.initial();
      const int index = 0;
      final bool result = useCase.call(board, index);
      expect(result, true);
    });

    test('should return false when cell is already occupied', () {
      final Board board = Board(
        cells: <Player>[
          Player.x,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
        ],
      );
      const int index = 0;
      final bool result = useCase.call(board, index);
      expect(result, false);
    });

    test('should return false when index is out of bounds', () {
      final Board board = Board.initial();
      const int index = 9;
      final bool result = useCase.call(board, index);
      expect(result, false);
    });

    test('should return false when board already has a winner', () {
      final Board board = Board(
        cells: <Player>[
          Player.x,
          Player.x,
          Player.x,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
        ],
        winningLine: const WinningLine(indices: <int>[0, 1, 2], player: Player.x),
      );
      const int index = 3;
      final bool result = useCase.call(board, index);
      expect(result, false);
    });
  });
}
