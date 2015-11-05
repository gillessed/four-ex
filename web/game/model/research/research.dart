part of model;

class Research {
  Player player;
  List<Technology> technologies;
  List<Technology> researchedTechnologies;
  Map<Technology, int> researchCount;
  Technology currentTechnology;
  int spareResearchPoints;
  int researchProgress;

  Research(this.player, this.technologies) {
    //TODO: pick better first tech?
    researchedTechnologies = [technologies[0]];
    currentTechnology = technologies[1];
    spareResearchPoints = 0;
    researchProgress = 3020;
    researchCount = {};
  }

  int getResearchCount(Technology technology) {
    if(researchCount.containsKey(technology)) {
      return researchCount[technology];
    } else {
      return 0;
    }
  }
  
  int getTotalResearch() {
    int baseResearch = player.controlledStarSystems.map((ControlledStarSystem system) {
      return system.colonies.map((Colony colony) {
        return colony.getResearch();
      }).reduce((var left, var right) {
        return left + right;
      });
    }).reduce((var left, var right) {
      return left + right;
    });
    //TODO: calculate global research bonus.
    return baseResearch;
  }

  bool prerequisitesMet(Technology technology) {
    if(researchedTechnologies.contains(technology) && !technology.repeatable) {
      return false;
    }
    for(Technology prereq in technology.prerequisites) {
      if(!researchedTechnologies.contains(prereq)) {
        return false;
      }
    }
    return true;
  }
}