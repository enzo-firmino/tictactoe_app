import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe_app/core/design_system/primary_button.dart';
import 'package:tictactoe_app/core/l10n/l10n.dart';
import 'package:tictactoe_app/core/router/app_router.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/game_info.dart';
import 'package:tictactoe_app/features/game/ultimate/domain/ultimate_game.dart';
import 'package:tictactoe_app/features/game/ultimate/presentation/providers/ultimate_game_provider.dart';
import 'package:tictactoe_app/features/game/ultimate/presentation/widget/ultimate_grid.dart';

class UltimateGameScreen extends ConsumerStatefulWidget {
  const UltimateGameScreen({super.key});

  @override
  ConsumerState<UltimateGameScreen> createState() => _UltimateGameScreenState();
}

class _UltimateGameScreenState extends ConsumerState<UltimateGameScreen> {
  @override
  Widget build(BuildContext context) {
    final UltimateGame game = ref.watch(ultimateGameProvider);
    final Player currentPlayer = ref.watch(ultimateGameProvider.select((UltimateGame game) => game.currentPlayer));
    final Player? winner = ref.watch(ultimateGameProvider.select((UltimateGame game) => game.winner));
    final UltimateGameNotifier gameNotifier = ref.read(ultimateGameProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GameInfo(currentPlayer: currentPlayer, winner: winner),
              UltimateGrid(
                game: game,
                onPlayMove: (int boardIndex, int cellIndex) {
                  gameNotifier.playUltimateMove(boardIndex, cellIndex);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  PrimaryButton(
                    text: context.l10n.home,
                    icon: FontAwesomeIcons.house,
                    onPressed: () {
                      const HomeRoute().go(context);
                    },
                  ),
                  PrimaryButton(
                    text: context.l10n.reset,
                    icon: FontAwesomeIcons.arrowRotateLeft,
                    onPressed: () {
                      gameNotifier.reset();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
