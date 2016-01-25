part of  model;

class Colony {
  static int baseMaxPopulation;
  ControlledStarSystem system;
  Planet planet;
  int population;
  List<OrbitalPlatform> orbitalPlatforms;
  // TODO: improvements
  
  Colony.max(SpaceProperties spaceProperties, this.planet) {
    planet.colony = this;
    population = getMaxPopulation();
    orbitalPlatforms = [];
  }

  List<Surface> getSurfaces() {
    List<Surface> surfaces = [new Surface(planet.tiles, 'Planet Surface')];
    for(OrbitalPlatform platform in orbitalPlatforms) {
      surfaces.add(new Surface(platform.tiles, 'Platform ${orbitalPlatforms.indexOf(platform) + 1}'));
    }
    return surfaces;
  }

  num getPopulationMil() {
    return population ~/ 1000000;
  }
  
  int getOutput() {
    return getPopulationMil();
  }
  
  int getMaxPopulation() {
    return (baseMaxPopulation * planet.populationRatio * getPopulationMaxBonus()).toInt();
  }
  
  num getPopulationMaxBonus() {
    //TODO: calculate bonus
    return 1;
  }
  
  int getIndustry() {
    Economy economy = system.player.economy;
    int output = getOutput();
    int industryOutput = (output * economy.economyRatio * economy.industryRatio).toInt();
    return industryOutput * getIndustryBonus();
  }
  
  num getIndustryBonus() {
    //TODO: calculate bonus
    return 1;
  }
  
  int getResearch() {
   //TODO: calculate colony research
    return 1;
  }
  
  num getResearchBonus() {
    //TODO: calculate research bonus
    return 1;
  }
}

class Surface {
  HexagonalLattice lattice;
  String name;
  Surface(this.lattice, this.name);
}