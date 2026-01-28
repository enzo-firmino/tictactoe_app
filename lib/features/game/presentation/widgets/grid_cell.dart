import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe_app/core/design_system/colors.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';
import 'package:tictactoe_app/features/game/presentation/utils/int_extension.dart';

class GridCell extends StatefulWidget {
  final Player player;
  final VoidCallback? onTap;
  final int index;

  const GridCell({super.key, required this.player, this.onTap, required this.index});

  @override
  State<GridCell> createState() => _GridCellState();
}

class _GridCellState extends State<GridCell> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    if (widget.player != Player.none) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(GridCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.player == Player.none && widget.player != Player.none) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: widget.index.rowGridWithCellIndex == 0 ? BorderSide.none : const BorderSide(color: Colors.black26),
            left: widget.index.colGridWithCellIndex == 0 ? BorderSide.none : const BorderSide(color: Colors.black26),
          ),
        ),
        child: Center(
          child: widget.player == Player.none
              ? null
              : AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          return FaIcon(
                            widget.player == Player.x ? FontAwesomeIcons.xmark : FontAwesomeIcons.circle,
                            color: widget.player == Player.x ? AppColors.red : AppColors.primary,
                            size: constraints.maxWidth / 2,
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
