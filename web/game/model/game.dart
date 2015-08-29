part of model;

abstract class DataFileController {
  Future getTestJson();
  Future getStarTypesJson();
  Future getStarNamesJson();
}

class Game {
  Space space;
  int turn;

  Game();
  
  factory Game.generate(SpaceProperties spaceProperties) {
    Game game = new Game();
    game.space = new Space.generate(spaceProperties);
    game.turn = 1;
    return game;
  }
}

