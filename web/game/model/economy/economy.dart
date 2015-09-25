part of model;

class Economy {
  Player player;
  
  num industryRatio;
  num researchRatio;
  num economyRatio;
  num productionRate;
  
  Economy.generate() {
    industryRatio = 0.25;
    researchRatio = 0.25;
    economyRatio = 0.5;
    productionRate = 0.5;
  }
}