part of model;

class Space {
  int width;
  int height;
  List<StarSystem> starSystems;
  
  Space(this.width, this.height, this.starSystems);
  
  factory Space.generate(SpaceProperties properties) {
    num pointCount = properties.width * properties.height * properties.planetFrequency;
    List<TPoint> starSystemPoints = getRandomPlanets(pointCount, properties.width, properties.height);
    List<StarSystem> starSystems = listMap(starSystemPoints, (TPoint pos) {
      String name = properties.starNames[random.nextInt(properties.starNames.length)];
      return new StarSystem.generate(properties, pos, name);
    });
    return new Space(properties.width, properties.height, starSystems);
  }
}

abstract class SpaceObject {
  TPoint pos;
  SpaceObject(this.pos);
  num getBoundingRadius();
}