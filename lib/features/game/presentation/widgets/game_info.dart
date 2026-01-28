import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe_app/core/design_system/colors.dart';
import 'package:tictactoe_app/core/l10n/l10n.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/game_player.dart';

class GameInfo extends ConsumerWidget {
  final Player? winner;
  final Player currentPlayer;

  const GameInfo({super.key, this.winner, required this.currentPlayer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: <Widget>[
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: winner == null ? 1.0 : 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GamePlayer(player: Player.o, isCurrent: currentPlayer == Player.o),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium,
                  children: <InlineSpan>[
                    TextSpan(
                      text: 'V',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: 'S',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(color: AppColors.red, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              GamePlayer(player: Player.x, isCurrent: currentPlayer == Player.x),
            ],
          ),
        ),
        AnimatedOpacity(
          opacity: winner != null ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Center(
            child: Text(
              winner == Player.none ? context.l10n.draw : context.l10n.playerWins(winner?.displayName ?? ''),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: winner?.color),
            ),
          ),
        ),
      ],
    );
  }
}
