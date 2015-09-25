part of view;

class ResearchContextView extends ContextView {
  ResearchContextButton contextButton;
  GameView gameView;
  
  ResearchContextView(Game model, this.gameView) : super(model) {
    contextButton = new ResearchContextButton(model, gameView, this);
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.fillStyle = 'rgb(255,255,255)';
    context.font = '30px geo';
    context.save();
    model.technologies.forEach((Technology technology) {
      context.translate(0, 30);
      context.fillText(technology.name, 30, 0);
    });
    context.restore();
  }
  
  @override
  ContextButton getContextButton() {
    return contextButton;
  }
}