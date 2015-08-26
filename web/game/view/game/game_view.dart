part of view;

class GameView extends View {
  
  Game model;
  HudBar hudBar;
  ContextView currentContextView;
  List<ContextView> contextViews;
  
  GameView(this.model) {
    currentContextView = new SpaceContextView(model, this);
    contextViews = [
      currentContextView,
      new InfluenceContextView(model, this),
      new ColoniesContextView(model, this),
      new ResearchContextView(model, this),
      new EconomyContextView(model, this),
      new DiplomacyContextView(model, this)
    ];
    addChild(
      currentContextView,
      new Placement(
        (parentWidth, parentHeight) {
          return new Translation(0, HudBar.HUD_BAR_HEIGHT);
        },
        (parentWidth, parentHeight) {
          return new Dimension(parentWidth, parentHeight - HudBar.HUD_BAR_HEIGHT);
        }
      )
    );
    hudBar = new HudBar(model, this);
    addChild(
      hudBar,
      new Placement(
        Translation.ZERO_F,
        Dimension.NO_OP)
    );
  }

  @override
  bool containsPoint(TPoint point) {
    return true;
  }
  
  void switchContextView(ContextView contextView) {
    if(contextView != currentContextView) {
      replaceChild(currentContextView, contextView);
      currentContextView = contextView;
    }
  }
}