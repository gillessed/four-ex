part of game_view;

class MainView extends View {
  MainModel model;
  VerticalScrollView2 scroller;
  MainMenuView mainMenuView;
  
  MainView(this.model) {
    mainMenuView = new MainMenuView(model, this);
    scroller = new VerticalScrollView2(mainMenuView);
    mainMenuView.scroller = scroller;
    addChild(
      scroller,
      new Placement(
        Translation.ZERO_F,
        (num parentWidth, num parentHeight) {
          return new Dimension(parentWidth, parentHeight);
    }));
    View.keyFocusView = mainMenuView;
  }

  @override
  bool containsPoint(TPoint point) {
    return true;
  }
  
  void newGame() {
    SpaceProperties spaceProperties = new SpaceProperties();
    spaceProperties.width = 50;
    spaceProperties.height = 50;
    spaceProperties.planetFrequency = 0.11;
    spaceProperties.starLayout = StarLayout.RANDOM;
    Future.wait([
      restController.getStarTypesJson(),
      restController.getStarNamesJson(),
      restController.getPlanetsJson(),
      restController.getConstantsJson(),
      restController.getTechnologiesJson()
    ]).then((values) {
      spaceProperties.starJson = values[0];
      spaceProperties.starNamesJson = values[1];
      spaceProperties.planetsJson = values[2];
      spaceProperties.constantsJson = values[3];
      spaceProperties.technologies = Technology.parseTechnologiesJson(values[4]);
      Game game = new Game.generate(spaceProperties, getDefaultPlayerProperties(), 0);
      GameView gameView = new GameView(game.humanPlayer.color, game);
      this.clearChildren();
      this.addChild(
        gameView, 
        new Placement(
          Translation.ZERO_F,
          (num parentWidth, num parentHeight) {
            return new Dimension(parentWidth, parentHeight);
      }));
      View.keyFocusView = gameView;
    });
  }
  
  List<PlayerProperties> getDefaultPlayerProperties() {
//    PlayerColorPalette p1 = new PlayerColorPalette('rgb(210,66,9)', 'rgb(237,128,9)', 'rgb(0,0,255)', 'rgb(0,0,255)');
    Theme p1 = new Theme('rgb(9,66,210)', 'rgb(9,128,237)', 'rgb(0,115,180)', 'rgb(0,0,255)');
    Theme p2 = new Theme.single('rgb(255,0,0)');
    Theme p3 = new Theme.single('rgb(0,255,0)');
    return [
      new PlayerProperties(p1, 'Human', 'Barack Obama', 'Sol'),
      new PlayerProperties(p2, 'Klingon', 'Gowron', 'Quonos'),
      new PlayerProperties(p3, 'Romulan', 'Praetor Shinzon', 'Romulus')
    ];
  }
}