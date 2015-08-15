part of model;

class MainModel {
  List<Function> newGameListener = [];
  
  Terminal mainMenuTerminal;
  Game game;
  
  MainModel() {
    mainMenuTerminal = new Terminal(this);
  }

  void newGame() {
    game = new Game.newGame();
    newGameListener.forEach((listener) {listener(game);});
  }
}