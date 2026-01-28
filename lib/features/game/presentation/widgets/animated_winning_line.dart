import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe_app/features/game/domain/entities/winning_line.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';

class AnimatedWinningLine extends StatefulWidget {
  final Widget child;
  final WinningLine? winningLine;

  const AnimatedWinningLine({super.key, required this.child, required this.winningLine});

  @override
  State<AnimatedWinningLine> createState() => _AnimatedWinningLineState();
}

class _AnimatedWinningLineState extends State<AnimatedWinningLine> with SingleTickerProviderStateMixin {
  late final AnimationController _lineController;

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    if (widget.winningLine != null) {
      _lineController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedWinningLine oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool hadWinningLine = oldWidget.winningLine != null;
    final bool hasWinningLine = widget.winningLine != null;

    if (hasWinningLine && !hadWinningLine) {
      _lineController.forward(from: 0);
    }
    if (!hasWinningLine && hadWinningLine) {
      _lineController.reset();
    }
  }

  @override
  void dispose() {
    _lineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _lineController,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          foregroundPainter: widget.winningLine != null
              ? _WinningLinePainter(
                  color: widget.winningLine!.player.color,
                  gridSize: 3,
                  winningLine: widget.winningLine!.indices,
                  progress: _lineController.value,
                )
              : null,
          child: widget.child,
        );
      },
    );
  }
}

class _WinningLinePainter extends CustomPainter {
  final List<int> winningLine;
  final double progress;
  final Color color;
  final int gridSize;

  _WinningLinePainter({required this.winningLine, required this.progress, required this.color, required this.gridSize});

  @override
  void paint(Canvas canvas, Size size) {
    if (winningLine.isEmpty) return;

    final Paint glowPaint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final double cellSize = size.width / gridSize;

    Offset getCellCenter(int index) {
      final int row = index ~/ gridSize;
      final int col = index % gridSize;
      return Offset(col * cellSize + cellSize / 2, row * cellSize + cellSize / 2);
    }

    final Offset start = getCellCenter(winningLine.first);
    final Offset end = getCellCenter(winningLine.last);

    final double dx = end.dx - start.dx;
    final double dy = end.dy - start.dy;
    final double length = sqrt(dx * dx + dy * dy);

    if (length == 0) return;

    final double unitX = dx / length;
    final double unitY = dy / length;

    final double extension = cellSize * 0.4;

    final Offset extendedStart = Offset(start.dx - unitX * extension, start.dy - unitY * extension);

    final Offset extendedEnd = Offset(end.dx + unitX * extension, end.dy + unitY * extension);

    final Offset currentEnd = Offset(
      extendedStart.dx + (extendedEnd.dx - extendedStart.dx) * progress,
      extendedStart.dy + (extendedEnd.dy - extendedStart.dy) * progress,
    );
    canvas.drawLine(extendedStart, currentEnd, glowPaint);
    canvas.drawLine(extendedStart, currentEnd, paint);
  }

  @override
  bool shouldRepaint(covariant _WinningLinePainter oldDelegate) {
    return oldDelegate.winningLine != winningLine ||
        oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.gridSize != gridSize;
  }
}
