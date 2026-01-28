import 'package:flutter/material.dart';
import 'package:tictactoe_app/core/design_system/colors.dart';
import 'package:tictactoe_app/features/game/domain/entities/board.dart';
import 'package:tictactoe_app/features/game/presentation/utils/int_extension.dart';
import 'package:tictactoe_app/features/game/presentation/widgets/grid_cell.dart';

const int gridSize = 3;

class Grid extends StatelessWidget {
  final Board board;
  final Function(int)? onTapCell;
  final int? indexInUltimateGrid;
  final Color? activeUltimateGridColor;

  const Grid({super.key, required this.board, this.onTapCell, this.indexInUltimateGrid, this.activeUltimateGridColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: activeUltimateGridColor ?? Colors.white,
        borderRadius: indexInUltimateGrid != null
            ? BorderRadius.only(
                bottomLeft: indexInUltimateGrid == 6 ? Radius.circular(14) : Radius.zero,
                bottomRight: indexInUltimateGrid == 8 ? Radius.circular(14) : Radius.zero,
                topRight: indexInUltimateGrid == 2 ? Radius.circular(14) : Radius.zero,
                topLeft: indexInUltimateGrid == 0 ? Radius.circular(14) : Radius.zero,
              )
            : BorderRadius.circular(12),
        border: indexInUltimateGrid != null
            ? Border(
                top: indexInUltimateGrid!.rowGridWithCellIndex == 0
                    ? BorderSide.none
                    : const BorderSide(color: AppColors.primary, width: 1),
                left: indexInUltimateGrid!.colGridWithCellIndex == 0
                    ? BorderSide.none
                    : const BorderSide(color: AppColors.primary, width: 1),
              )
            : Border.all(color: AppColors.primary, width: 1),
      ),
      padding: const EdgeInsets.all(4),
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: gridSize),
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            return GridCell(
              player: board.cells[index],
              index: index,
              onTap: () {
                onTapCell?.call(index);
              },
            );
          },
        ),
      ),
    );
  }
}
