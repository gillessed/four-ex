part of model;

class Research {
  Player player;
  List<Technology> technologies;
  List<Technology> researchedTechnologies;
  Technology currentTechnology;
  int spareResearchPoints;
  int researchProgress;

  Research(this.player, this.technologies) {
    //TODO: pick better first tech?
    researchedTechnologies = [technologies[0]];
    currentTechnology = technologies[1];
    spareResearchPoints = 0;
    researchProgress = 0;
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
    for(Technology prereq in technology.prerequisites) {
      if(!researchedTechnologies.contains(prereq)) {
        return false;
      }
    }
    return true;
  }
}