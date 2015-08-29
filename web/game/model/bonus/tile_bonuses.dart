part of model;

/**
 * Probabilities that a 100%, 300% or 700% bonus
 * appears on a tile or a non-planet object.
 */
class TileBonusProbabilities {
  List<num> industry = [0, 0, 0];
  List<num> populationMax = [0, 0, 0];
  List<num> populationGrowth = [0, 0, 0];
  List<num> economy = [0, 0, 0];
  List<num> research = [0, 0, 0];
  List<num> happiness = [0, 0, 0];
  List<num> influence = [0, 0, 0];
  
  TileBonusProbabilities();
  
  TileBonusProbabilities.fromJson(Map jsonObject) {
    if(jsonObject.containsKey("INDUSTRY")) {
      industry = jsonObject["INDUSTRY"];
    }
    if(jsonObject.containsKey("POPLUATION_MAX")) {
      populationMax = jsonObject["POPLUATION_MAX"];
    }
    if(jsonObject.containsKey("POPULATION_GROWTH")) {
      populationGrowth = jsonObject["POPULATION_GROWTH"];
    }
    if(jsonObject.containsKey("ECONOMY")) {
      economy = jsonObject["ECONOMY"];
    }
    if(jsonObject.containsKey("RESEARCH")) {
      research = jsonObject["RESEARCH"];
    }
    if(jsonObject.containsKey("HAPPINESS")) {
      happiness = jsonObject["HAPPINESS"];
    }
    if(jsonObject.containsKey("INFLUENCE")) {
      influence = jsonObject["INFLUENCE"];
    }
  }
  
  Bonus generateBonus() {
    
  }
}