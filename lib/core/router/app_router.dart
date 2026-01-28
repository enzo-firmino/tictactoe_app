import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe_app/features/game/classic/presentation/screens/classic_game_screen.dart';
import 'package:tictactoe_app/features/game/presentation/screens/home_screen.dart';
import 'package:tictactoe_app/features/game/ultimate/presentation/screens/ultimate_game_screen.dart';

part 'app_router.g.dart';

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<ClassicGameRoute>(path: '/classic-game')
class ClassicGameRoute extends GoRouteData with $ClassicGameRoute {
  const ClassicGameRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ClassicGameScreen();
  }
}

@TypedGoRoute<UltimateGameRoute>(path: '/ultimate-game')
class UltimateGameRoute extends GoRouteData with $UltimateGameRoute {
  const UltimateGameRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UltimateGameScreen();
  }
}

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: const HomeRoute().location,
    routes: $appRoutes,
  );
}