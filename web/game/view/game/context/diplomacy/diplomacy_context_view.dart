part of game_view;

class DiplomacyContextView extends ContextView {
  DiplomacyContextButton contextButton;
  GameView gameView;
  
  DiplomacyContextView(Game model, this.gameView) : super(model) {
    contextButton = new DiplomacyContextButton(model, gameView, this);
  }
  
  @override
  ContextButton getContextButton() {
    return contextButton;
  }
}