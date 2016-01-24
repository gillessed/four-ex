part of game_view;

class EconomyContextView extends ContextView {
  EconomyContextButton contextButton;
  GameView gameView;
  
  EconomyContextView(Game model, this.gameView) : super(model) {
    contextButton = new EconomyContextButton(model, gameView, this);
  }
  
  @override
  ContextButton getContextButton() {
    return contextButton;
  }
}