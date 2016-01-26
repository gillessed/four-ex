part of model;

class ImprovementBlueprint {
  String name;
  String description;
  int cost;
  int maxCountPerPlanet;
  int maxCountPerSystem;
  int maxCount;
  List<Technology> requirements;
  List<Bonus> planetBonuses;
  List<Bonus> systemBonuses;
  List<Bonus> globalBonuses;
  List<ImprovementBlueprint> requiredImprovements;
}