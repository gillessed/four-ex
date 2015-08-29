part of model;

class GasGiant extends PlanetaryBody {
  int index;
  Bonus bonus;
  String get name => '${starSystem.name} ${ROMAN_NUMERALS[index]}';
  
  GasGiant(this.index, this.bonus);
  
  factory GasGiant.generate(SpaceProperties properties, int index) {
    int amount = random.nextInt(50) + 50;
    Bonus bonus;
    if(random.nextDouble() > 0.5) {
      bonus = new HappinessBonus(amount);
    } else {
      bonus = new ResearchBonus(amount); 
    }
    return new GasGiant(index, bonus);
  }
}