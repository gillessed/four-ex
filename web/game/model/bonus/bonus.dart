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

enum Application {
  PLUS,
  TIMES
}

Map<BonusType, String> _BONUS_NAMES = {
  BonusType.INDUSTRY: 'Industry',
  BonusType.ECONOMY: 'Economy',
  BonusType.RESEARCH: 'Research',
  BonusType.POPULATION_MAX: 'Population Max',
  BonusType.INFLUENCE: 'Influence',
  BonusType.HAPPINESS: 'Happiness',
  BonusType.POPULATION_GROWTH: 'Population Growth'
};


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
  num amount;
  Application application;
  
  Bonus(this.type, this.amount, this.application);

  String humanReadableString() {
    return '${_BONUS_NAMES[type]}: ${application == Application.PLUS ? 'x' : '+'}${amount}';
  }
  
  static Bonus createTileBonus(BonusType type, List<num> probabilities) {
    num rand = random.nextDouble();
    num total = probabilities[0];
    if(rand < total) {
      return new Bonus(type, BIG_BONUS, Application.TIMES);
    }
    total += probabilities[1];
    if(rand < total) {
      return new Bonus(type, BIGGER_BONUS, Application.TIMES);
    }
    total += probabilities[2];
    if(rand < total) {
      return new Bonus(type, BIGGEST_BONUS, Application.TIMES);
    }
    return null;
  }
  
  static List<Bonus> parseJsonList(Map json) {
    List<Bonus> bonuses = [];
    json.forEach((String key, String amountStr) {
      Application application;
      if(amountStr.startsWith('+')) {
        application = Application.PLUS;
      } else if(amountStr.startsWith('x')) {
        application = Application.TIMES;
      } else {
        throw new StateError('Unknown application type: ${amountStr}');
      }
      num amount = num.parse(amountStr.substring(1));
      bonuses.add(new Bonus(_getBonusType(key), amount, application));
    });
    return bonuses;
  }
}
