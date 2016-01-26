part of game_view;

class TileStatusView extends View {

  TileStatusView(Tile tile) {

  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..fillStyle = 'rgb(0,0,0)'
      ..beginPath()
      ..rect(0, 0, width, height)
      ..fill();
  }
}