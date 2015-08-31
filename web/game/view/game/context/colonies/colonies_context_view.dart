part of view;

class ColoniesContextView extends ContextView {
  ColoniesContextButton contextButton;
  GameView gameView;
  
  ColoniesContextView(Game model, this.gameView) : super(model) {
    contextButton = new ColoniesContextButton(model, gameView, this);
  }
  
  @override
  ContextButton getContextButton() {
    return contextButton;
  }
}