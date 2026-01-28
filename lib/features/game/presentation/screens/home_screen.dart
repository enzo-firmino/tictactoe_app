import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe_app/core/design_system/colors.dart';
import 'package:tictactoe_app/core/design_system/primary_button.dart';
import 'package:tictactoe_app/core/l10n/l10n.dart';
import 'package:tictactoe_app/core/router/app_router.dart';
import 'package:tictactoe_app/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe_app/features/game/domain/enum/game_mode.dart';
import 'package:tictactoe_app/features/game/presentation/providers/game_settings_provider.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/game_mode_carousel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            children: <Widget>[
              Text(
                context.l10n.appTitle,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.primaryDark),
              ),
              SizedBox(height: 24),
              GameModeCarousel(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  children: <Widget>[
                    PrimaryButton(
                      text: context.l10n.vs,
                      icon: FontAwesomeIcons.user,
                      secondIcon: FontAwesomeIcons.user,
                      onPressed: () {
                        _startGame(false, ref, context);
                      },
                    ),
                    SizedBox(height: 24),
                    PrimaryButton(
                      text: context.l10n.vs,
                      icon: FontAwesomeIcons.user,
                      secondIcon: FontAwesomeIcons.desktop,
                      onPressed: () {
                        _startGame(true, ref, context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startGame(bool isVsAi, WidgetRef ref, BuildContext context) {
    ref.read(gameSettingsProvider.notifier).setIsVsIa(isVsAi);
    final GameSettings settings = ref.read(gameSettingsProvider);

    if (settings.gameMode == GameMode.classic) {
      const ClassicGameRoute().go(context);
    } else {
      const UltimateGameRoute().go(context);
    }
  }
}
