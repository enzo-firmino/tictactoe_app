import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictactoe_app/core/design_system/colors.dart';
import 'package:tictactoe_app/core/l10n/l10n.dart';
import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/domain/entities/game_settings.dart';
import 'package:tictactoe_app/features/game/domain/enum/game_mode.dart';
import 'package:tictactoe_app/features/game/presentation/providers/game_settings_provider.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/animated_winning_line.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/grid.dart';
import 'package:tictactoe_app/features/game/ultimate/domain/ultimate_game.dart';
import 'package:tictactoe_app/features/game/ultimate/presentation/widget/ultimate_grid.dart';

class GameModeCarousel extends ConsumerStatefulWidget {
  const GameModeCarousel({super.key});

  @override
  ConsumerState<GameModeCarousel> createState() => GridSizeCarouselState();
}

class GridSizeCarouselState extends ConsumerState<GameModeCarousel> {
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final GameSettingsNotifier gameSettingsNotifier = ref.read(gameSettingsProvider.notifier);
    final GameMode gameMode = ref.watch(gameSettingsProvider.select((GameSettings value) => value.gameMode));
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: GameMode.values.length,
          itemBuilder: (BuildContext context, int index, _) {
            final GameMode currentGameMode = GameMode.values[index];
            return Column(
              children: <Widget>[
                Text(
                  currentGameMode == GameMode.classic ? context.l10n.gameModeClassic : context.l10n.gameModeUltimate,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(color: AppColors.primaryDark),
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: currentGameMode == GameMode.classic
                      ? AnimatedWinningLine(
                          winningLine: Board.winningO().winningLine,
                          child: Grid(board: Board.winningO()),
                        )
                      : UltimateGrid(game: UltimateGame.example()),
                ),
              ],
            );
          },
          options: CarouselOptions(
            aspectRatio: 1,
            initialPage: gameMode == GameMode.classic ? 0 : 1,
            enlargeCenterPage: true,
            enlargeFactor: 0.4,
            viewportFraction: 0.7,
            enableInfiniteScroll: false,
            onPageChanged: (int index, _) {
              gameSettingsNotifier.setGameMode(GameMode.values[index]);
            },
          ),
        ),
        _NavigationArrow(gameMode: gameMode, carouselController: _carouselController),
      ],
    );
  }
}

class _NavigationArrow extends ConsumerWidget {
  final GameMode gameMode;
  final CarouselSliderController carouselController;

  const _NavigationArrow({required this.gameMode, required this.carouselController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isClassicGameMode = gameMode == GameMode.classic;
    return Positioned(
      left: isClassicGameMode ? null : 16,
      right: isClassicGameMode ? 16 : null,
      child: GestureDetector(
        onTap: () {
          carouselController.animateToPage(
            isClassicGameMode ? 1 : 0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
        child: FaIcon(
          isClassicGameMode ? FontAwesomeIcons.caretRight : FontAwesomeIcons.caretLeft,
          color: AppColors.secondary,
          size: 52,
          shadows: <Shadow>[Shadow(blurRadius: 6, offset: Offset(0, 3), color: Colors.black26)],
        ),
      ),
    );
  }
}
