part of view;

class MainView extends View {
  MainModel model;
  VerticalScrollView scroller;
  MainMenuView mainMenuView;
  
  MainView(this.model) {
    mainMenuView = new MainMenuView(model.mainMenuTerminal);
    scroller = new VerticalScrollView(mainMenuView);
    mainMenuView.scroller = scroller;
    children[scroller] = new Translation(0, 0);
    View.focusedView = mainMenuView;
    
    model.newGameListener.add((game) {
      GameView gameView = new GameView(game);
      children.clear();
      children[gameView] = new Translation(0, 0);
      View.focusedView = gameView;
    });
  }
  
  @override
  void drawComponent(CanvasRenderingContext2D context, num width, num height) {}
}