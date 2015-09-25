part of model;

const int BIG_BONUS = 100;
const int BIGGER_BONUS = 300;
const int BIGGEST_BONUS = 700;

enum BonusType {
  INDUSTRY,
  ECONOMY,
  RESEARCH,
  POPULATION_MAX,
  POPULATION_GROWTH,
  INFLUENCE,
  HAPPINESS
}

BonusType _getBonusType(String key) {
  BonusType bonusType;
  _BONUS_KEYS.forEach((BonusType type, String name) {
    if(key == name) {
      bonusType = type;
    }
  });
  if(bonusType == null) {
    throw new StateError('Found no bonus type to match ${key}.');
  }
  return bonusType;
}

class Bonus {
  BonusType type;
  int amount;
  
  Bonus(this.type, this.amount);
  
  static Bonus createTileBonus(BonusType type, List<num> probabilities) {
    num rand = random.nextDouble();
    num total = probabilities[0];
    if(rand < total) {
      return new Bonus(type, BIG_BONUS);
    }
    total += probabilities[1];
    if(rand < total) {
      return new Bonus(type, BIGGER_BONUS);
    }
    total += probabilities[2];
    if(rand < total) {
      return new Bonus(type, BIGGEST_BONUS);
    }
    return null;
  }
  
  static List<Bonus> parseJsonList(Map json) {
    List<Bonus> bonuses = [];
    json.forEach((String key, int amount) {
      bonuses.add(new Bonus(_getBonusType(key), amount));
    });
    return bonuses;
  }
}
