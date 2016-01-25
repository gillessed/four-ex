part of game_view;

class ColonyStatusView extends View {

  Function colonyGetter;
  Colony get colony => colonyGetter();

  ColonyStatusView(this.colonyGetter) {

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