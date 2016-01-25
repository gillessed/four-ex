part of game_view;

class ImprovementListView extends View {
  ImprovementListView() {

  }

  num computeHeight() {
    return 1400;
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