part of game_view;

class ColoniesContextView extends ContextView {
  static const num SELECTOR_HEIGHT = 40;
  static const num STATUS_HEIGHT = 150;
  static const OFFSET = 1;
  
  ColoniesContextButton contextButton;
  GameView gameView;
  ListSelectorView<ControlledStarSystem> starSystemSelectorView;
  StarSystemSelector starSystemSelector;
  ListSelectorView<Colony> colonySelectorView;
  ColonySelector colonySelector;
  ColonyImprovementsView colonyImprovementView;
  ColonyStatusView colonyStatusView;
  
  ColoniesContextView(Game model, this.gameView) : super(model) {
    contextButton = new ColoniesContextButton(model, gameView, this);
    starSystemSelector = new StarSystemSelector(model.humanPlayer);
    starSystemSelectorView = new ListSelectorView(
        starSystemSelector,
        300,
        (ControlledStarSystem controlled) {return controlled.starSystem.name;},
        model.humanPlayer.color.color1,
        'rgb(255,255,255)',
        '30px geo',
        2,
        onItemChanged: (_) {
          // TODO: implement when we have more than one star system
        });
    addChild(
      starSystemSelectorView,
      new Placement(
        Translation.ZERO_F,
        (num parentWidth, num parentHeight) {
          return new Dimension(parentWidth / 2, SELECTOR_HEIGHT);
        })
    );
    colonySelector = new ColonySelector(starSystemSelector.currentStarSystem);
    colonySelectorView = new ListSelectorView(
        colonySelector,
        300,
        (Colony colony) {return colony.planet.name;},
        model.humanPlayer.color.color1,
        'rgb(255,255,255)',
        '30px geo',
        2);
    addChild(
      colonySelectorView,
      new Placement(
        (num parentWidth, num parentHeight) {
          return new Translation(parentWidth / 2, 0);
        },
        (num parentWidth, num parentHeight) {
          return new Dimension(parentWidth / 2, SELECTOR_HEIGHT);
        })
    );

    colonyStatusView = new ColonyStatusView(() => colonySelector.current());
    addChild(
        colonyStatusView,
        new Placement(
            (num parentWidth, num parentHeight) {
          return new Translation(OFFSET, SELECTOR_HEIGHT + STATUS_HEIGHT);
        },
            (num parentWidth, num parentHeight) {
          return new Dimension(parentWidth - OFFSET * 2, STATUS_HEIGHT);
        })
    );


    colonyImprovementView = new ColonyImprovementsView(() => colonySelector.current());
    addChild(
      colonyImprovementView,
      new Placement(
        (num parentWidth, num parentHeight) {
          return new Translation(OFFSET, SELECTOR_HEIGHT + OFFSET + STATUS_HEIGHT);
        },
        (num parentWidth, num parentHeight) {
          return new Dimension(parentWidth - OFFSET * 2, parentHeight - SELECTOR_HEIGHT - 2 * OFFSET - STATUS_HEIGHT);
        })
    );
  }

  @override
  ContextButton getContextButton() {
    return contextButton;
  }
}

class StarSystemSelector extends Selector<ControlledStarSystem> {
  Player player;
  ControlledStarSystem currentStarSystem;
  
  StarSystemSelector(this.player) {
    currentStarSystem = player.controlledStarSystems[0];
  }
  
  @override
  ControlledStarSystem current() {
    return currentStarSystem;
  }

  @override
  void next() {
    int length = player.controlledStarSystems.length;
    for(int i = 0; i < length; i++) {
      if(currentStarSystem.starSystem == player.controlledStarSystems[i].starSystem) {
        currentStarSystem = player.controlledStarSystems[(i + 1) % length];
        break;
      }
    }
  }

  @override
  void previous() {
    int length = player.controlledStarSystems.length;
    for(int i = 0; i < length; i++) {
      if(currentStarSystem.starSystem == player.controlledStarSystems[i].starSystem) {
        currentStarSystem = player.controlledStarSystems[(i - 1 + length) % length];
        break;
      }
    }
  }
}

class ColonySelector extends Selector<Colony> {
  ControlledStarSystem currentStarSystem;
  Colony currentColony;
  
  ColonySelector(this.currentStarSystem) {
    currentColony = currentStarSystem.colonies[0];
  }
  
  @override
  Colony current() {
    return currentColony;
  }

  @override
  void next() {
    int length = currentStarSystem.colonies.length;
    for(int i = 0; i < length; i++) {
      if(currentColony.planet == currentStarSystem.colonies[i].planet) {
        currentColony = currentStarSystem.colonies[(i + 1) % length];
        break;
      }
    }
  }

  @override
  void previous() {
    int length = currentStarSystem.colonies.length;
    for(int i = 0; i < length; i++) {
      if(currentColony.planet == currentStarSystem.colonies[i].planet) {
        currentColony = currentStarSystem.colonies[(i - 1 + length) % length];
        break;
      }
    }
  }
}