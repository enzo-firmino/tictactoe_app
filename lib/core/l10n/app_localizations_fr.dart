// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Morpion';

  @override
  String get gameModeClassic => 'Classique';

  @override
  String get gameModeUltimate => 'Ultime';

  @override
  String get startGame => 'Commencer';

  @override
  String get player => 'Joueur';

  @override
  String get vs => 'VS';

  @override
  String get settings => 'Paramètres';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get home => 'Menu';

  @override
  String get draw => 'Égalité !';

  @override
  String playerWins(Object player) {
    return 'Le joueur $player gagne !';
  }
}
