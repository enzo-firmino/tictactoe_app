import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';
import 'package:tictactoe_app/features/game/domain/usecases/make_move_usecase.dart';

void main() {
  late MakeMoveUseCase useCase;

  setUp(() {
    useCase = MakeMoveUseCase();
  });

  group('MakeMoveUseCase', () {
    test('should place X at the specified index', () {
      final Board board = Board.initial();
      const int index = 4;
      const Player player = Player.x;
      final Board result = useCase.call(board, index, player);
      expect(result.cells[4], Player.x);
      expect(result.cells.where((Player p) => p == Player.x).length, 1);
    });

    test('should place O at the specified index', () {
      final Board board = Board.initial();
      const int index = 0;
      const Player player = Player.o;
      final Board result = useCase.call(board, index, player);
      expect(result.cells[0], Player.o);
      expect(result.cells.where((Player p) => p == Player.o).length, 1);
    });
  });
}
