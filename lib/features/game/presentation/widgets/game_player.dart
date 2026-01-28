import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe_app/core/design_system/colors.dart';
import 'package:tictactoe_app/core/l10n/l10n.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';

class GamePlayer extends StatelessWidget {
  final Player player;
  final bool isCurrent;

  const GamePlayer({super.key, required this.player, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      scale: isCurrent ? 1.5 : 1.0,
      child: Column(
        children: <Widget>[
          FaIcon(
            player == Player.x ? FontAwesomeIcons.xmark : FontAwesomeIcons.circle,
            color: player == Player.x ? AppColors.red : AppColors.primary,
            size: 32,
          ),
          Text(
            context.l10n.player,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: player == Player.x ? AppColors.red : AppColors.primary),
          ),
        ],
      ),
    );
  }
}
