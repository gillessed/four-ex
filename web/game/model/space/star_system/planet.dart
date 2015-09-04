part of model;

class Planet extends PlanetaryBody {
  static const int TILE_NUM = 10;
  static const int MAX_QUALITY = TILE_NUM * TILE_NUM;
  
  int index;
  num quality;
  String type;
  String get name => '${starSystem.name} ${ROMAN_NUMERALS[index]}';
  String get nameQuality => '${name} (${quality})';
  List<List<Tile>> tiles;
  Colony colony;
  
  Planet(this.index, this.quality, this.type, this.tiles);
  
  factory Planet.generate(SpaceProperties properties, int index) {
    
    /*
     * "TYPE": "M-Class",
    "QUALITY_RANGE": [30, 60],
    "TILE_BONUSES": {
      "POP_GROWTH": [0.05, 0.02, 0.005],
      "RESEARCH": [0.005, 0, 0],
      "INDUSTRY": [0.005, 0, 0],
      "INFLUENCE": [0.01, 0, 0],
      "HAPPINESS": [0.03, 0.01, 0.001],
      "ECONOMY": [0.02, 0.001, 0]
    }
     */
    Map planetTypeJson = properties.planetsJson[random.nextInt(properties.planetsJson.length)];
    String type = planetTypeJson["TYPE"];
    List<num> qualityRange = planetTypeJson["QUALITY_RANGE"];
    int quality = ((random.nextDouble() * (qualityRange[1] - qualityRange[0]) + qualityRange[0]) * Planet.MAX_QUALITY).toInt();
    
    // Generate Tiles
    // TODO
    
    return new Planet(index, quality, type, []);
  }
}