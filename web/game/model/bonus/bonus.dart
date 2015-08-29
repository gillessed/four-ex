part of model;

/*
 * 
  List<num> industry = [0, 0, 0];
  List<num> populationMax = [0, 0, 0];
  List<num> populationGrowth = [0, 0, 0];
  List<num> economy = [0, 0, 0];
  List<num> research = [0, 0, 0];
  List<num> happiness = [0, 0, 0];
  List<num> influence = [0, 0, 0];
 */

class Bonus {
  String type;
  int amount;
  Bonus(this.type, this.amount);
}

class IndustryBonus extends Bonus {
  IndustryBonus(int amount) : super('INDUSTRY', amount);
}

class PopulationMaxBonus extends Bonus {
  PopulationMaxBonus(int amount) : super('POPULATION_MAX', amount);
}

class PopulationGrowthBonus extends Bonus {
  PopulationGrowthBonus(int amount) : super('POPULATION_GROWTH', amount);
}

class EconomyBonus extends Bonus {
  EconomyBonus(int amount) : super('ECONOMY', amount);
}

class ResearchBonus extends Bonus {
  ResearchBonus(int amount) : super('RESEARCH', amount);
}

class HappinessBonus extends Bonus {
  HappinessBonus(int amount) : super('HAPPINESS', amount);
}

class InfluenceBonus extends Bonus {
  InfluenceBonus(int amount) : super('INFLUENCE', amount);
}