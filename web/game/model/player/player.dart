part of model;

class Player {
  PlayerColorPalette color;
  String speciesName;
  String leaderName;
  List<ControlledStarSystem> controlledStarSystems;
  ControlledStarSystem get homeSystem => controlledStarSystems.first;
  Economy economy;
  SpaceProperties spaceProperties;
  Research research;
  
  Player(
      this.spaceProperties,
      this.color,
      this.speciesName,
      this.leaderName,
      this.controlledStarSystems,
      this.economy,
      List<Technology> technologies) {
    research = new Research(this, technologies);
  }
  
  factory Player.generate(SpaceProperties spaceProperties, PlayerProperties playerProperties, StarSystem homeSystem) {
    ControlledStarSystem homeControlledSystem = new ControlledStarSystem.homeSystem(spaceProperties, homeSystem);
    Player player = new Player(
        spaceProperties,
        playerProperties.playerColor,
        playerProperties.speciesName, 
        playerProperties.leaderName,
        [homeControlledSystem],
        new Economy.generate(),
        spaceProperties.technologies);
    homeControlledSystem.setPlayer(player);
    return player;
  }
}

class ControlledStarSystem {
  Player player;
  StarSystem starSystem;
  List<Colony> colonies;
  ControlledStarSystem.homeSystem(SpaceProperties spaceProperties, this.starSystem) {
    starSystem.controlledStarSystem = this;
    colonies = [];
    starSystem.planets.forEach((Planet planet) {
      colonies.add(new Colony.max(spaceProperties, planet));
    });
  }
  
  void setPlayer(Player player) {
    this.player = player;
    colonies.forEach((Colony colony) {
      colony.system = this;
    });
  }
}