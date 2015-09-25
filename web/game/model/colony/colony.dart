part of  model;

class Colony {
  static int baseMaxPopulation;
  ControlledStarSystem system;
  Planet planet;
  int population;
  // TODO: improvements
  
  Colony.max(SpaceProperties spaceProperties, this.planet) {
    planet.colony = this;
    population = getMaxPopulation();
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
    
  }
}