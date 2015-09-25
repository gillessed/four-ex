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
    } while(points.isNotEmpty ? minDistanceTo(p, points) < Star.MAX_RADIUS * 2.1 : false);
    points.add(p);
  }
  return points;
}

List<TPoint> getHomePlanets(
    int width,
    int height,
    int count,
    num minDistanceBetween,
    num maxDistanceToOtherPlanet,
    List<TPoint> existingSystems) {
  var homePoints = [];
  for(int i = 0; i < count; i++) {
      TPoint p;
      do {
        p = new TPoint(random.nextDouble() * width, random.nextDouble() * height);
      } while(minDistanceTo(p, existingSystems) > maxDistanceToOtherPlanet ||
           minDistanceTo(p, existingSystems) < Star.MAX_RADIUS * 2.1 ||
          (homePoints.isEmpty ? false : minDistanceTo(p, homePoints) < minDistanceBetween));
      homePoints.add(p);
    }
    return homePoints;
}

num minDistanceTo(TPoint point, List<TPoint> points) {
  return points
    .map((TPoint p) {return point.distanceTo(p);})
    .reduce((num d1, num d2) {return min(d1, d2);});
}

class SpaceProperties {
  
  static const String _PLANET_COUNT_DISTRIBUTION = "PLANET_COUNT_DISTRIBUTION";
  static const String _NON_PLANET_FREQUENCY = "NON_PLANET_FREQUENCY";
  static const String _DEFAULT_PLANET_POPULATION = "DEFAULT_PLANET_POPULATION";
  
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
  List<Technology> technologies;
  
  String get nextPlanetName => starNamesJson[random.nextInt(starNamesJson.length)];
  List<num> get planetCountDistribution => constantsJson[_PLANET_COUNT_DISTRIBUTION];
  num get nonPlanetFrequency => constantsJson[_NON_PLANET_FREQUENCY];
  int get defaultPlanetPopulation => constantsJson[_DEFAULT_PLANET_POPULATION];
}