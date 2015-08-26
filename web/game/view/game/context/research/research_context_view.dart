part of view;

class ResearchContextView extends ContextView {
  ResearchContextButton contextButton;
  GameView gameView;
  
  ResearchContextView(Game model, this.gameView) : super(model) {
    contextButton = new ResearchContextButton(gameView, this);
  }
  
  @override
  ContextButton getContextButton() {
    return contextButton;
  }
}