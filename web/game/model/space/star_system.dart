part of model;

class StarSystem extends SpaceObject {
  String name;
  Star star;
  StarSystem(TPoint pos, this.name, this.star) : super(pos);
  
  factory StarSystem.generate(SpaceProperties properties, TPoint pos, String name) {
    var starType = properties.starJson[random.nextInt(properties.starJson.length)];
    num sizeMin = starType['SIZE'][0];
    num sizeMax = starType['SIZE'][1];
    num starSize = sizeMin + random.nextDouble() * (sizeMax - sizeMin);
    Star star = new Star(
        starType['GRADIENT'][0],
        starType['GRADIENT'][1],
        starSize);
    return new StarSystem(pos, name, star);
  }
  
  num getBoundingRadius() {
    return Star.MAX_RADIUS * 1.1;
  }
}