part of model;

enum StarLayout {
  SPIRAL,
  TIGHT_CLUSTERS,
  LOOSE_CLUSTERS,
  RANDOM
}

Map<StarLayout, Function> STAR_LAYOUTS = {
  StarLayout.RANDOM: getRandomPlanets
};

List<TPoint> getRandomPlanets(int count, int width, int height) {
  var points = [];
  for(int i = 0; i < count; i++) {
    TPoint p;
    do {
      p = new TPoint(random.nextDouble() * width, random.nextDouble() * height);
    } while(listReduce(listMap(points, (l) {return p.distanceTo(l) < Star.MAX_RADIUS * 2.1;}), (bool s, bool t) {return s || t;}, startValue: false));
    points.add(p);
  }
  return points;
}

class SpaceProperties {
  
  static const String _PLANET_COUNT_DISTRIBUTION = "PLANET_COUNT_DISTRIBUTION";
  static const String _NON_PLANET_FREQUENCY = "NON_PLANET_FREQUENCY";
  
  num width;
  num height;
  num starSystemFrequency;
  num planetFrequency;
  num habitablePlanetFrequency;
  num minorRaceFrequency;
  num spaceJunkFrequency;
  num spaceJunkAppearanceFrequency;
  num anomalyFrequency;
  num resourceFrequency;
  StarLayout starLayout;
  
  List starJson;
  List starNamesJson;
  List planetsJson;
  Map constantsJson;
  
  String get nextPlanetName => starNamesJson[random.nextInt(starNamesJson.length)];
  List<num> get planetCountDistribution => constantsJson[_PLANET_COUNT_DISTRIBUTION];
  num get nonPlanetFrequency => constantsJson[_NON_PLANET_FREQUENCY];
}