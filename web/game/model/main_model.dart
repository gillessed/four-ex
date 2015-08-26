part of model;

class MainModel {
  List<Function> newGameListener = [];
  
  Terminal mainMenuTerminal;
  Game game;
  
  MainModel() {
    mainMenuTerminal = new Terminal(this);
  }

  void newGame() {
    SpaceProperties defaults = new SpaceProperties();
    defaults.width = 50;
    defaults.height = 50;
    defaults.planetFrequency = 0.1;
    Game.newGame(defaults).then((newGame) {
      game = newGame;
      newGameListener.forEach((listener) {listener(game);});
    });
  }
}