part of  model;

class Colony {
  Player player;
  Planet planet;
  int population;
  // TODO: improvements
  
  Colony.max(SpaceProperties spaceProperties, this.planet) {
    population = spaceProperties.defaultPlanetPopulation;
    planet.colony = this;
  }
}