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

List<Point> getRandomPlanets(int count, int width, int height) {
  var points = [];
  for(int i = 0; i < count; i++) {
    Point p;
    do {
      p = new Point(random.nextDouble() * width, random.nextDouble() * height);
    } while(listReduce(listMap(points, (l) {return p.distanceTo(l) < Star.MAX_RADIUS * 2.1;}), (bool s, bool t) {return s || t;}, startValue: false));
    points.add(p);
  }
  return points;
}

class SpaceProperties {
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
}