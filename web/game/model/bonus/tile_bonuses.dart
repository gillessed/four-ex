part of model;

Map<BonusType, String> _BONUS_KEYS = {
  BonusType.INDUSTRY: 'INDUSTRY',
  BonusType.ECONOMY: 'ECONOMY',
  BonusType.RESEARCH: 'RESEARCH',
  BonusType.POPULATION_MAX: 'POPULATION_MAX',
  BonusType.INFLUENCE: 'INFLUENCE',
  BonusType.HAPPINESS: 'HAPPINESS',
  BonusType.POPULATION_GROWTH: 'POPULATION_GROWTH'
};

/**
 * Probabilities that a 100%, 300% or 700% bonus
 * appears on a tile or a non-planet object.
 */
class TileBonusProbabilities {
  Map<BonusType, List<num>> probabilities = {};
  
  TileBonusProbabilities();
  
  TileBonusProbabilities.fromJson(Map jsonObject) {
    for(BonusType type in BonusType.values) {
      String key = _BONUS_KEYS[type];
      if(jsonObject.containsKey(key)) {
        probabilities[type] = jsonObject[key];
      }
    }
  }
  
  List<Bonus> generate() {
    List<Bonus> bonuses = [];
    probabilities.forEach((BonusType type, List<num> probabilities) {
      Bonus bonus = Bonus.createTileBonus(type, probabilities);
      if(bonus != null) {
        bonuses.add(bonus);
      }
    });
    return bonuses;
  }
}