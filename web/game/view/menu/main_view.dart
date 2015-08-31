part of view;

class MainView extends View {
  MainModel model;
  VerticalScrollView scroller;
  MainMenuView mainMenuView;
  
  MainView(this.model) {
    mainMenuView = new MainMenuView(model, this);
    scroller = new VerticalScrollView(mainMenuView);
    mainMenuView.scroller = scroller;
    addChild(
      scroller,
      new Placement(
        Translation.ZERO_F,
        (num parentWidth, num parentHeight) {
          return new Dimension(parentWidth, parentHeight);
    }));
    View.focusedView = mainMenuView;
  }

  @override
  bool containsPoint(TPoint point) {
    return true;
  }
  
  void newGame() {
    
    
    
    SpaceProperties spaceProperties = new SpaceProperties();
    spaceProperties.width = 50;
    spaceProperties.height = 50;
    spaceProperties.planetFrequency = 0.1;
    spaceProperties.starLayout = StarLayout.RANDOM;
    Future.wait([
      restController.getStarTypesJson(),
      restController.getStarNamesJson(),
      restController.getPlanetsJson(),
      restController.getConstantsJson()
    ]).then((values) {
      spaceProperties.starJson = values[0];
      spaceProperties.starNamesJson = values[1];
      spaceProperties.planetsJson = values[2];
      spaceProperties.constantsJson = values[3];
      Game game = new Game.generate(spaceProperties, getDefaultPlayerProperties(), 0);
      GameView gameView = new GameView(game);
      this.clearChildren();
      this.addChild(
        gameView, 
        new Placement(
          Translation.ZERO_F,
          (num parentWidth, num parentHeight) {
            return new Dimension(parentWidth, parentHeight);
      }));
      View.focusedView = gameView;
    });
  }
  
  List<PlayerProperties> getDefaultPlayerProperties() {
    return [
      new PlayerProperties('rgb(255,0,0)', 'Human', 'Barack Obama', 'Sol'),
      new PlayerProperties('rgb(0,255,0)', 'Klingon', 'Gowron', 'Quonos'),
      new PlayerProperties('rgb(0,0,255)', 'Romulan', 'Praetor Shinzon', 'Romulus')
    ];
  }
}