import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tictactoe_app/features/game/domain/enum/player.dart';

part 'winning_line.freezed.dart';

@freezed
abstract class WinningLine with _$WinningLine {
  const factory WinningLine({
    required List<int> indices,
    required Player player,
  }) = _WinningLine;
}

