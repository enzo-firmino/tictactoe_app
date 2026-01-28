extension IntExtension on int {
  int get rowGridWithCellIndex => this ~/ 3;
  int get colGridWithCellIndex => this % 3;
}
