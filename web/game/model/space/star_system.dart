part of model;

class StarSystem extends SpaceObject {
  Star star;
  StarSystem(num x, num y, this.star) : super(x, y);
  
  factory StarSystem.generate(SpaceProperties properties, num x, num y) {
    var starType = properties.starJson[random.nextInt(properties.starJson.length)];
    num sizeMin = starType['SIZE'][0];
    num sizeMax = starType['SIZE'][1];
    num starSize = sizeMin + random.nextDouble() * (sizeMax - sizeMin);
    Star star = new Star(
        starType['GRADIENT'][0],
        starType['GRADIENT'][1],
        starSize);
    return new StarSystem(x, y, star);
  }
}