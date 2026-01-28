import 'package:flutter/material.dart';
import 'package:tictactoe_app/core/design_system/colors.dart';
import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/animated_winning_board.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/animated_winning_line.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/grid.dart';
import 'package:tictactoe_app/features/game/ultimate/domain/ultimate_game.dart';

const int ultimateGridSize = 3;

class UltimateGrid extends StatefulWidget {
  final UltimateGame game;
  final Function(int boardIndex, int cellIndex)? onPlayMove;

  const UltimateGrid({super.key, required this.game, this.onPlayMove});

  @override
  State<UltimateGrid> createState() => _UltimateGridState();
}

class _UltimateGridState extends State<UltimateGrid> with SingleTickerProviderStateMixin {
  late final AnimationController _opacityController;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _opacityController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

    _opacityAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.3, end: 0.7).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.7, end: 0.3).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_opacityController);
  }

  @override
  void dispose() {
    _opacityController.dispose();
    super.dispose();
  }

  void _triggerOpacityChange() {
    _opacityController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.none,
        child: AspectRatio(
          aspectRatio: 1,
          child: AnimatedWinningLine(
            winningLine: widget.game.winningLine,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: ultimateGridSize),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                final Board board = widget.game.boards[index];
                final bool isActiveBoard = widget.game.activeBoard == index;
                return AnimatedBuilder(
                  animation: _opacityAnimation,
                  builder: (BuildContext context, Widget? child) {
                    final double opacity = isActiveBoard ? _opacityAnimation.value : 0.3;
                    return AnimatedWinningBoard(
                      winningLine: board.winningLine,
                      child: Grid(
                        board: board,
                        activeUltimateGridColor: isActiveBoard
                            ? widget.game.currentPlayer.color.withValues(alpha: opacity)
                            : null,
                        onTapCell: (int gridIndex) {
                          if (!board.isFree) {
                            return;
                          }
                          if (widget.game.activeBoard != null && widget.game.activeBoard != index) {
                            _triggerOpacityChange();
                            return;
                          }
                          widget.onPlayMove?.call(index, gridIndex);
                        },
                        indexInUltimateGrid: index,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
