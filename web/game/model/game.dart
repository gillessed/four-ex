part of model;

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
  
  static Future<Game> newGame(SpaceProperties spaceProperties) {
    return restController.getStarTypesJson().then((starJson) {
      spaceProperties.starJson = starJson;
      return new Game.generate(spaceProperties);
    });
  }
}