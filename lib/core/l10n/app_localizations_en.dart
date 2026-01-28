// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Morpion';

  @override
  String get gameModeClassic => 'Classic';

  @override
  String get gameModeUltimate => 'Ultimate';

  @override
  String get startGame => 'Start';

  @override
  String get player => 'Player';

  @override
  String get vs => 'VS';

  @override
  String get settings => 'Settings';

  @override
  String get reset => 'Reset';

  @override
  String get home => 'Home';

  @override
  String get draw => 'It\'s a draw!';

  @override
  String playerWins(Object player) {
    return 'Player $player wins!';
  }
}
