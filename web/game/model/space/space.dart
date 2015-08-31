part of model;

class Space {
  int width;
  int height;
  int get largestDimension => min(width, height);
  List<StarSystem> starSystems;
  Map<PlayerProperties, StarSystem> homeSystems;

  Space(this.width, this.height, this.starSystems, this.homeSystems);
  
  factory Space.generate(SpaceProperties properties, List<PlayerProperties> playerPropertiesList) {
    num pointCount = properties.width * properties.height * properties.planetFrequency;
    List<TPoint> starSystemPoints = STAR_LAYOUTS[properties.starLayout](pointCount, properties.width, properties.height);
    List<StarSystem> starSystems = starSystemPoints.map((TPoint pos) {
      String name = properties.nextPlanetName;
      return new StarSystem.generate(properties, pos, name);
    }).toList();
    
    List<TPoint> homeSystemPoints = getHomePlanets(
        properties.width,
        properties.height,
        playerPropertiesList.length,
        min(properties.width, properties.height) / 5,
        3,
        starSystemPoints);
    Map<PlayerProperties, StarSystem> homeSystems = {};
    for(int i = 0; i < playerPropertiesList.length; i++) {
      num startingPlanetCount = 5;
      PlayerProperties playerProperties = playerPropertiesList[i];
      StarSystem homeSystem = new StarSystem.generateWithCount(properties, homeSystemPoints[i], playerProperties.homeSystemName, startingPlanetCount);
      homeSystems[playerProperties] = homeSystem;
    }
    starSystems.addAll(homeSystems.values);
    return new Space(properties.width, properties.height, starSystems, homeSystems);
  }
}

abstract class SpaceObject {
  TPoint pos;
  SpaceObject(this.pos);
  num getBoundingRadius();
}