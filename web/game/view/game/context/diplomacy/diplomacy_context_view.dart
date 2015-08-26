part of view;

class DiplomacyContextView extends ContextView {
  DiplomacyContextButton contextButton;
  GameView gameView;
  
  DiplomacyContextView(Game model, this.gameView) : super(model) {
    contextButton = new DiplomacyContextButton(gameView, this);
  }
  
  @override
  ContextButton getContextButton() {
    return contextButton;
  }
}