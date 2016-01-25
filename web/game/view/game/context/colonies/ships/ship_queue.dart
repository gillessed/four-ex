part of game_view;

class ShipQueueView extends View {
  ShipQueueView() {

  }

  num computeHeight() {
    return 400;
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