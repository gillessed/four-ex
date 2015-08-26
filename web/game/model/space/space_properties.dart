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
    points.add(new Point(random.nextDouble() * width, random.nextDouble() * height));
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