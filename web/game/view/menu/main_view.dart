part of view;

class MainView extends View {
  MainModel model;
  VerticalScrollView scroller;
  MainMenuView mainMenuView;
  
  MainView(this.model) {
    mainMenuView = new MainMenuView(model.mainMenuTerminal);
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
    
    model.newGameListener.add((game) {
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

  @override
  bool containsPoint(TPoint point) {
    return true;
  }
}