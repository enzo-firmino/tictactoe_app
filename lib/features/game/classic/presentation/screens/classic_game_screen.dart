import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe_app/core/design_system/primary_button.dart';
import 'package:tictactoe_app/core/l10n/l10n.dart';
import 'package:tictactoe_app/core/router/app_router.dart';
import 'package:tictactoe_app/features/game/classic/domain/classic_game.dart';
import 'package:tictactoe_app/features/game/classic/presentation/providers/classic_game_provider.dart';
import 'package:tictactoe_app/features/game/classic/presentation/widgets/classic_grid.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/game_info.dart';

class ClassicGameScreen extends ConsumerWidget {
  const ClassicGameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Player currentPlayer = ref.watch(classicGameProvider.select((ClassicGame game) => game.currentPlayer));
    final Player? winner = ref.watch(classicGameProvider.select((ClassicGame game) => game.winner));
    final ClassicGameNotifier classicGameNotifier = ref.read(classicGameProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GameInfo(currentPlayer: currentPlayer, winner: winner),
              const ClassicGrid(),
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
                      classicGameNotifier.reset();
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
