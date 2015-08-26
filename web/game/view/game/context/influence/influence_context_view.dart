part of view;

class InfluenceContextView extends ContextView {
  InfluenceContextButton contextButton;
  GameView gameView;
  
  InfluenceContextView(Game model, this.gameView) : super(model) {
    contextButton = new InfluenceContextButton(gameView, this);
  }
  
  @override
  ContextButton getContextButton() {
    return contextButton;
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..fillStyle = "rgb(255,0,0)"
      ..font = "50px Geo"
      ..textAlign = "center"
      ..fillText("Influence View", width / 2, height / 2);
  }
}