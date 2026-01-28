import 'package:flutter/widgets.dart';
import 'package:tictactoe_app/core/l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}