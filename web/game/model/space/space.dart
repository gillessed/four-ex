part of model;

class Space {
  int width;
  int height;
  List<StarSystem> starSystems;
  
  Space(this.width, this.height, this.starSystems);
  
  factory Space.generate(SpaceProperties properties) {
    num pointCount = properties.width * properties.height * properties.planetFrequency;
    List<Point> starSystemPoints = getRandomPlanets(pointCount, properties.width, properties.height);
    List<StarSystem> starSystems = listMap(starSystemPoints, (Point p) {
      return new StarSystem.generate(properties, p.x, p.y);
    });
    return new Space(properties.width, properties.height, starSystems);
  }
}

class SpaceObject {
  num x;
  num y;
  SpaceObject(this.x, this.y);
}