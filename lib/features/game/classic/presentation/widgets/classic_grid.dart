import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_app/features/game/classic/domain/classic_game.dart';
import 'package:tictactoe_app/features/game/classic/presentation/providers/classic_game_provider.dart';
import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/animated_winning_line.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/grid.dart';

class ClassicGrid extends ConsumerWidget {
  const ClassicGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Board board = ref.watch(classicGameProvider.select((ClassicGame game) => game.board));
    final ClassicGameNotifier classicGameNotifier = ref.read(classicGameProvider.notifier);

    return AnimatedWinningLine(
      winningLine: board.winningLine,
      child: Grid(board: board, onTapCell: classicGameNotifier.playClassicMove),
    );
  }
}
