part of model;

class StarSystem extends SpaceObject {
  String name;
  Star star;
  List<PlanetaryBody> planetaryBodies;
  StarSystem(TPoint pos, this.name, this.star, this.planetaryBodies) : super(pos);
  
  num getBoundingRadius() {
    return Star.MAX_RADIUS * 1.1;
  }
  
  factory StarSystem.generate(SpaceProperties properties, TPoint pos, String name) {
    // Generate star
    var starType = properties.starJson[random.nextInt(properties.starJson.length)];
    num sizeMin = starType['SIZE'][0];
    num sizeMax = starType['SIZE'][1];
    num starSize = sizeMin + random.nextDouble() * (sizeMax - sizeMin);
    Star star = new Star(
        starType['GRADIENT'][0],
        starType['GRADIENT'][1],
        starSize);
    
    // Count number of planets/bodies
    int planetCount = 1;
    num randomValue = random.nextDouble();
    num probabilitySum = 0;
    properties.planetCountDistribution.forEach((probability) {
      probabilitySum += probability;
      if(randomValue > probabilitySum) {
        planetCount++;
      }
    });
    
    // Generate planets/bodies
    List<PlanetaryBody> planetaryBodies = [];
    bool hasAsteroidBelt = false;
    for(int i = 0; i < planetCount; i++) {
      int index = i + 1 - (hasAsteroidBelt ? 1 : 0);
      if(random.nextDouble() < properties.nonPlanetFrequency) {
        // Gas Giant
        planetaryBodies.add(new GasGiant.generate(properties, index));
      } else if(random.nextDouble() < properties.nonPlanetFrequency && !hasAsteroidBelt) {
        // Asteroid Belt
        hasAsteroidBelt = true;
        planetaryBodies.add(new AsteroidBelt.generate(properties));
      } else {
        // Habitable Planet
        planetaryBodies.add(new Planet.generate(properties, index));
      }
    }
    
    StarSystem starSystem = new StarSystem(pos, name, star, planetaryBodies);
    planetaryBodies.forEach((body) {
      body.starSystem = starSystem;
    });
    return starSystem;
  }
}

/**
 * Identifying interface.
 */
class PlanetaryBody {
  StarSystem starSystem;
}

List<String> ROMAN_NUMERALS = [
  'I',
  'II',
  'III',
  'IV',
  'V',
  'VI',
  'VII',
  'VIII',
  'IX',
  'X',
];