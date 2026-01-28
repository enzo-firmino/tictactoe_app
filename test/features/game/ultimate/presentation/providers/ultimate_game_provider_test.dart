import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';
import 'package:tictactoe_app/features/game/ultimate/domain/ultimate_game.dart';
import 'package:tictactoe_app/features/game/ultimate/presentation/providers/ultimate_game_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('UltimateGameNotifier - Initialization', () {
    test('should initialize with 9 empty boards', () {
      final UltimateGame game = container.read(ultimateGameProvider);
      expect(game.boards.length, 9);
      for (final Board board in game.boards) {
        expect(board.cells.every((Player p) => p == Player.none), true);
      }
      expect(game.currentPlayer == Player.x || game.currentPlayer == Player.o, true);
      expect(game.winner, isNull);
      expect(game.activeBoard, isNull);
    });
  });

  group('UltimateGameNotifier - Basic Move Logic', () {
    test('should place mark on specified board and cell', () async {
      final UltimateGameNotifier notifier = container.read(ultimateGameProvider.notifier);
      final Player initialPlayer = container.read(ultimateGameProvider).currentPlayer;

      await notifier.playUltimateMove(0, 4);
      final UltimateGame game = container.read(ultimateGameProvider);

      expect(game.boards[0].cells[4], initialPlayer);
      expect(game.currentPlayer, initialPlayer.opponent);
    });

    test('should set active board to the cell index played', () async {
      final UltimateGameNotifier notifier = container.read(ultimateGameProvider.notifier);
      await notifier.playUltimateMove(0, 4);
      final UltimateGame game = container.read(ultimateGameProvider);
      expect(game.activeBoard, 4);
    });
  });

  group('UltimateGameNotifier - Active Board Restriction', () {
    test('should not allow move on inactive board', () async {
      final UltimateGameNotifier notifier = container.read(ultimateGameProvider.notifier);
      await notifier.playUltimateMove(0, 4);
      final UltimateGame afterFirst = container.read(ultimateGameProvider);
      expect(afterFirst.activeBoard, 4);
      await notifier.playUltimateMove(2, 0);
      final UltimateGame afterInvalid = container.read(ultimateGameProvider);
      expect(afterInvalid.boards[2].cells[0], Player.none);
      expect(afterInvalid.activeBoard, 4);
    });

    test('should allow move on active board only', () async {
      final UltimateGameNotifier notifier = container.read(ultimateGameProvider.notifier);
      final Player firstPlayer = container.read(ultimateGameProvider).currentPlayer;
      await notifier.playUltimateMove(0, 4);
      final UltimateGame afterFirst = container.read(ultimateGameProvider);
      expect(afterFirst.activeBoard, 4);
      await notifier.playUltimateMove(4, 2);
      final UltimateGame afterSecond = container.read(ultimateGameProvider);
      expect(afterSecond.boards[4].cells[2], firstPlayer.opponent);
      expect(afterSecond.activeBoard, 2);
    });
  });
}
