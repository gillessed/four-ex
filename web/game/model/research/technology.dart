part of model;

class Technology {
  String name;
  String description;
  int cost;
  bool repeatable;
  List<Bonus> staticBonuses;
  List<Technology> prerequisites;
  
  Technology.fromJson(Map json) {
    name = json["NAME"];
    description = json["DESCRIPTION"];
    cost = json["COST"];
    repeatable = json.containsKey("REPEATABLE") && json["REPEATABLE"] == "true";
    staticBonuses = [];
    if(json.containsKey("BONUSES")) {
      staticBonuses.addAll(Bonus.parseJsonList(json["BONUSES"]));
    }
    prerequisites = [];
  }
  
  static List<Technology> parseTechnologiesJson(List json) {
    print(json);
    print(json == null);
    print(json is List);
    List<Technology> technologies = [];
    Map<String, Technology> technologyMap = {};
    Map<String, List<String>> prequisiteMap = {};
    json.forEach((var obj) {
      Technology tech = new Technology.fromJson(obj);
      technologies.add(tech);
      technologyMap[tech.name] = tech;
      prequisiteMap[tech.name] = obj["PREREQUISITES"];
    });
    prequisiteMap.forEach((String name, List<String> prereqs) {
      Technology tech = technologyMap[name];
      prereqs.forEach((String prereq) {
        tech.prerequisites.add(technologyMap[prereq]);
      });
    });
    return technologies;
  }
}