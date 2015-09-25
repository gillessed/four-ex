part of model;

class Game {
  Space space;
  int turn;
  List<Player> players;
  Player humanPlayer;
  List<Technology> technologies;
  
  Game(this.space, this.turn, this.players, this.humanPlayer, this.technologies);
  
  factory Game.generate(SpaceProperties spaceProperties, List<PlayerProperties> playerPropertiesList, int humanPlayer) {
    Colony.baseMaxPopulation = spaceProperties.defaultPlanetPopulation;
    Space space = new Space.generate(spaceProperties, playerPropertiesList);
    List<Player> players = [];
    playerPropertiesList.forEach((PlayerProperties playerProperties) {
      players.add(new Player.generate(spaceProperties, playerProperties, space.homeSystems[playerProperties]));
    });
    return new Game(space, 1, players, players[humanPlayer], spaceProperties.technologies);
  }
}

