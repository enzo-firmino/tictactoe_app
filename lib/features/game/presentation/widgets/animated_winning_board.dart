import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe_app/features/game/domain/entities/winning_line.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';

class AnimatedWinningBoard extends StatefulWidget {
  final Widget child;
  final WinningLine? winningLine;

  const AnimatedWinningBoard({super.key, required this.child, this.winningLine});

  @override
  State<AnimatedWinningBoard> createState() => _AnimatedWinningBoardState();
}

class _AnimatedWinningBoardState extends State<AnimatedWinningBoard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));

    if (widget.winningLine != null) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedWinningBoard oldWidget) {
    super.didUpdateWidget(oldWidget);

    final bool hadWinner = oldWidget.winningLine != null;
    final bool hasWinner = widget.winningLine != null;

    if (hasWinner && !hadWinner) {
      _controller.forward(from: 0);
    }
    if (!hasWinner && hadWinner) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Player? winner = widget.winningLine?.player;

    return Stack(
      children: <Widget>[
        widget.child,
        if (winner != null && winner != Player.none)
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return CustomPaint(
                painter: _WinningSymbolPainter(player: winner, color: winner.color, progress: _controller.value),
                child: Container(),
              );
            },
          ),
      ],
    );
  }
}

class _WinningSymbolPainter extends CustomPainter {
  final Player player;
  final Color color;
  final double progress;

  _WinningSymbolPainter({required this.player, required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint glowPaint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..strokeWidth = size.width * 0.12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double symbolSize = size.width * 0.6;

    if (player == Player.o) {
      final double radius = symbolSize / 2;
      final Rect rect = Rect.fromCircle(center: Offset(centerX, centerY), radius: radius);
      final double sweepAngle = 2 * pi * progress;

      canvas.drawArc(rect, -pi / 2, sweepAngle, false, glowPaint);
      canvas.drawArc(rect, -pi / 2, sweepAngle, false, paint);
    } else if (player == Player.x) {
      final double halfSize = symbolSize / 2;
      if (progress > 0) {
        final double firstLineProgress = (progress * 2).clamp(0.0, 1.0);
        final Offset start1 = Offset(centerX - halfSize, centerY - halfSize);
        final Offset end1 = Offset(centerX + halfSize, centerY + halfSize);
        final Offset current1 = Offset(
          start1.dx + (end1.dx - start1.dx) * firstLineProgress,
          start1.dy + (end1.dy - start1.dy) * firstLineProgress,
        );

        canvas.drawLine(start1, current1, glowPaint);
        canvas.drawLine(start1, current1, paint);
      }

      if (progress > 0.5) {
        final double secondLineProgress = ((progress - 0.5) * 2).clamp(0.0, 1.0);
        final Offset start2 = Offset(centerX + halfSize, centerY - halfSize);
        final Offset end2 = Offset(centerX - halfSize, centerY + halfSize);
        final Offset current2 = Offset(
          start2.dx + (end2.dx - start2.dx) * secondLineProgress,
          start2.dy + (end2.dy - start2.dy) * secondLineProgress,
        );

        canvas.drawLine(start2, current2, glowPaint);
        canvas.drawLine(start2, current2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WinningSymbolPainter oldDelegate) {
    return oldDelegate.player != player || oldDelegate.color != color || oldDelegate.progress != progress;
  }
}
