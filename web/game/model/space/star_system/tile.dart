part of model;

class Tile {
  List<Bonus> bonuses;
  Tile(this.bonuses);
  
  factory Tile.generate(SpaceProperties properties, TileBonusProbabilities bonuses) {
    return new Tile(bonuses.generate());
  }
}