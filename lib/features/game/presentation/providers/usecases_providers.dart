import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe_app/features/game/domain/usecases/ai_move_usecase.dart';
import 'package:tictactoe_app/features/game/domain/usecases/check_winning_line_usecase.dart';
import 'package:tictactoe_app/features/game/domain/usecases/make_move_usecase.dart';
import 'package:tictactoe_app/features/game/domain/usecases/validate_move_usecase.dart';

part 'usecases_providers.g.dart';

@riverpod
MakeMoveUseCase makeMoveUseCase(_) {
  return MakeMoveUseCase();
}

@riverpod
CheckWinningLineUseCase checkWinningLineUseCase(_) {
  return CheckWinningLineUseCase();
}

@riverpod
ValidateMoveUseCase validateMoveUseCase(_) {
  return ValidateMoveUseCase();
}

@riverpod
AiMoveUseCase aiMoveUseCase(_) {
  return AiMoveUseCase();
}
