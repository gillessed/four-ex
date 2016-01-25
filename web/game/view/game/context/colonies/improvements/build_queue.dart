part of game_view;

class BuildQueueView extends View {
  BuildQueueView() {

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