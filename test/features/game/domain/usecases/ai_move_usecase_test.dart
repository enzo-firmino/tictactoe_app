import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';
import 'package:tictactoe_app/features/game/domain/usecases/ai_move_usecase.dart';

void main() {
  late AiMoveUseCase useCase;

  setUp(() {
    useCase = AiMoveUseCase();
  });

  group('AiMoveUseCase - Win Detection', () {
    test('should take winning move when AI can win', () {
      final Board board = Board(
        cells: <Player>[
          Player.x,
          Player.x,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
        ],
      );
      const Player aiPlayer = Player.x;
      final int? result = useCase.call(board, aiPlayer);
      expect(result, 2);
    });

    test('should take winning move in column', () {
      // Arrange
      final Board board = Board(
        cells: <Player>[
          Player.o,
          Player.none,
          Player.none,
          Player.o,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
        ],
      );
      const Player aiPlayer = Player.o;
      final int? result = useCase.call(board, aiPlayer);
      expect(result, 6);
    });

    test('should take winning move in diagonal', () {
      final Board board = Board(
        cells: <Player>[
          Player.x,
          Player.none,
          Player.none,
          Player.none,
          Player.x,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
        ],
      );
      const Player aiPlayer = Player.x;
      final int? result = useCase.call(board, aiPlayer);
      expect(result, 8);
    });
  });

  group('AiMoveUseCase - Block Detection', () {
    test('should block opponent from winning', () {
      final Board board = Board(
        cells: <Player>[
          Player.o,
          Player.o,
          Player.none,
          Player.x,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
        ],
      );
      const Player aiPlayer = Player.x;
      final int? result = useCase.call(board, aiPlayer);
      expect(result, 2);
    });

    test('should block opponent from winning in column', () {
      // Arrange
      final Board board = Board(
        cells: <Player>[
          Player.x,
          Player.o,
          Player.none,
          Player.none,
          Player.o,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
        ],
      );
      const Player aiPlayer = Player.x;
      final int? result = useCase.call(board, aiPlayer);
      expect(result, 7);
    });
  });

  group('AiMoveUseCase - Random Move', () {
    test('should return empty cell index when no winning or blocking move', () {
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
      const Player aiPlayer = Player.o;
      final int? result = useCase.call(board, aiPlayer);
      expect(result, isNotNull);
      expect(result! >= 0 && result < 9, true);
      expect(board.cells[result], Player.none);
    });

    test('should return null when board is full', () {
      final Board board = Board(
        cells: <Player>[Player.x, Player.o, Player.x, Player.o, Player.x, Player.o, Player.o, Player.x, Player.o],
      );
      const Player aiPlayer = Player.x;
      final int? result = useCase.call(board, aiPlayer);
      expect(result, isNull);
    });

    test('should only return index of empty cell', () {
      // Arrange
      final Board board = Board(
        cells: <Player>[Player.x, Player.o, Player.x, Player.o, Player.x, Player.o, Player.o, Player.x, Player.none],
      );
      const Player aiPlayer = Player.o;
      final int? result = useCase.call(board, aiPlayer);
      expect(result, 8);
    });
  });

  group('AiMoveUseCase - Priority', () {
    test('should prioritize winning over blocking', () {
      final Board board = Board(
        cells: <Player>[
          Player.x,
          Player.x,
          Player.none,
          Player.o,
          Player.o,
          Player.none,
          Player.none,
          Player.none,
          Player.none,
        ],
      );
      const Player aiPlayer = Player.x;
      final int? result = useCase.call(board, aiPlayer);
      expect(result, 2);
    });
  });
}
