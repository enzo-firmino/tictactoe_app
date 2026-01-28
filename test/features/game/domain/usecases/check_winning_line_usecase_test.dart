import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe_app/features/game/domain/entities/winning_line.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';
import 'package:tictactoe_app/features/game/domain/usecases/check_winning_line_usecase.dart';

void main() {
  late CheckWinningLineUseCase useCase;

  setUp(() {
    useCase = CheckWinningLineUseCase();
  });

  group('CheckWinningLineUseCase', () {
    test('should detect winning line in first row', () {
      final List<Player> cells = <Player>[
        Player.x,
        Player.x,
        Player.x,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
      ];

      final WinningLine? result = useCase.call(cells);
      expect(result, isNotNull);
      expect(result!.player, Player.x);
      expect(result.indices, <int>[0, 1, 2]);
    });

    test('should detect winning line in first column', () {
      final List<Player> cells = <Player>[
        Player.x,
        Player.none,
        Player.none,
        Player.x,
        Player.none,
        Player.none,
        Player.x,
        Player.none,
        Player.none,
      ];

      final WinningLine? result = useCase.call(cells);
      expect(result, isNotNull);
      expect(result!.player, Player.x);
      expect(result.indices, <int>[0, 3, 6]);
    });

    test('should detect winning line in main diagonal', () {
      final List<Player> cells = <Player>[
        Player.x,
        Player.none,
        Player.none,
        Player.none,
        Player.x,
        Player.none,
        Player.none,
        Player.none,
        Player.x,
      ];

      final WinningLine? result = useCase.call(cells);
      expect(result, isNotNull);
      expect(result!.player, Player.x);
      expect(result.indices, <int>[0, 4, 8]);
    });

    test('should return null when game is in progress', () {
      final List<Player> cells = <Player>[
        Player.x,
        Player.o,
        Player.x,
        Player.o,
        Player.x,
        Player.none,
        Player.none,
        Player.none,
        Player.none,
      ];

      final WinningLine? result = useCase.call(cells);
      expect(result, isNull);
    });

    test('should return null when game is a draw', () {
      final List<Player> cells = <Player>[
        Player.x,
        Player.o,
        Player.x,
        Player.o,
        Player.o,
        Player.x,
        Player.o,
        Player.x,
        Player.o,
      ];

      final WinningLine? result = useCase.call(cells);
      expect(result, isNull);
    });
  });
}
