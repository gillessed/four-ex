part of model;

class Planet extends PlanetaryBody {
  static const int TILE_WIDTH = 10;
  static const int TILE_HEIGHT = 5;
  static const int MAX_QUALITY = TILE_WIDTH * TILE_HEIGHT;
  
  int index;
  num quality;
  num populationRatio;
  String type;
  String get name => '${starSystem.name} ${ROMAN_NUMERALS[index]}';
  String get nameQuality => '${name} (${quality})';
  HexagonalLattice<Tile> tiles;
  Colony colony;
  
  Planet(this.index, this.quality, this.populationRatio, this.type, this.tiles);
  
  factory Planet.generate(SpaceProperties properties, int index) {
    
    Map planetTypeJson = properties.planetsJson[random.nextInt(properties.planetsJson.length)];
    String type = planetTypeJson['TYPE'];
    
    List<num> qualityRange = planetTypeJson['QUALITY_RANGE'];
    int quality = ((random.nextDouble() * (qualityRange[1] - qualityRange[0]) + qualityRange[0]) * Planet.MAX_QUALITY).toInt();
    
    List<num> populationRange = planetTypeJson['POPULATION_RANGE'];
    num populationRatio = (random.nextDouble() * (populationRange[1] - populationRange[0]) + populationRange[0]);
    
    TileBonusProbabilities tileBonusProbabilities = new TileBonusProbabilities.fromJson(planetTypeJson['TILE_BONUSES']);
    
    HexagonalLattice<Tile> tiles = new HexagonalLattice.empty(true, false, TILE_WIDTH, TILE_HEIGHT);
    for(int i = 0; i < quality; i++) {
      int x;
      int y;
      do {
        var point = tiles.getRandomPoint();
        x = point['x'];
        y = point['y'];
      } while(tiles.get(x, y) != null);
      Tile tile = new Tile.generate(properties, tileBonusProbabilities);
      tiles.set(tile, x, y);
    }
    
    return new Planet(index, quality, populationRatio, type, tiles);
  }
}