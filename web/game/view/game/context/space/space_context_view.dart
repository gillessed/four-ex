part of game_view;

class SpaceContextView extends ContextView {
  SpaceContextButton contextButton;
  GameView gameView;
  
  StatusBarView statusBarView;
  SpaceView spaceView;

  SpaceContextView(Game model, this.gameView) : super(model) {
    contextButton = new SpaceContextButton(model, gameView, this);
    spaceView = new SpaceView(model, this);
    addChild(
      spaceView,
      new Placement(
        Translation.ZERO_F,
        (parentWidth, parentHeight) {
          return new Dimension(parentWidth, parentHeight - StatusBarView.STATUS_BAR_HEIGHT);
        }
      )
    );
    statusBarView = new StatusBarView(model, this, spaceView);
    addChild(
      statusBarView,
      new Placement(
        (parentWidth, parentHeight) {
          return new Translation(0, parentHeight - StatusBarView.STATUS_BAR_HEIGHT);
        },
        (parentWidth, parentHeight) {
          return new Dimension(parentWidth, StatusBarView.STATUS_BAR_HEIGHT);
        }
      )
    );
  }

  @override
  ContextButton getContextButton() {
    return contextButton;
  }
  
  void setStatusView(SpaceObject spaceObject) {
    statusBarView.setStatusView(spaceObject);
  }
  
  SpaceObject getSelectedObject() {
    return statusBarView.selected;
  }
}
