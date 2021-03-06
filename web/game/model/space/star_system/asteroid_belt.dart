part of model;

class AsteroidBelt extends PlanetaryBody {
  Bonus bonus;
  String get name => '${starSystem.name} Belt';
  
  AsteroidBelt(this.bonus);
  
  factory AsteroidBelt.generate(SpaceProperties properties) {
    int amount = random.nextInt(50) + 50;
    Bonus bonus;
    if(random.nextDouble() > 0.5) {
      bonus = new Bonus(BonusType.INDUSTRY, amount);
    } else {
      bonus = new Bonus(BonusType.ECONOMY, amount); 
    }
    return new AsteroidBelt(bonus);
  }
}