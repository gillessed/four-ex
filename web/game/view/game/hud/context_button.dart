part of view;

abstract class ContextButton extends View {
  static const num OFFSET = 5;
  static const num SIZE = HudBar.HUD_BAR_HEIGHT - 2 * OFFSET;

  static const String DEFAULT_FILL = "rgb(0,0,0)";
  static const String HOVER_FILL = "rgb(50,50,50)";
  static const String CLICK_FILL = "rgb(255,255,255)";
  static const String SELECTED_FILL = "rgb(0,0,0)";
  static const String HOVER_FOREGROUND = "rgb(255,255,255)";
  static const String CLICK_FOREGROUND = "rgb(0,0,0)";
  static const String SELECTED_FOREGROUND = "rgb(255,255,255)";

  int index;
  Polygon polygon;
  GameView gameView;
  ContextView contextView;
  Game model;

  ContextButton(this.model, this.gameView, this.contextView) {
    polygon = new Polygon([
      new TPoint(0, 0),
      new TPoint(SIZE, 0),
      new TPoint(SIZE, SIZE),
      new TPoint(0, SIZE),
    ]);
  }

  bool containsPoint(TPoint p) {
    return polygon.contains(p);
  }

  String getFillColour() {
    if (gameView.currentContextView.getContextButton() == this) {
      return SELECTED_FILL;
    } else if (View.hoveredViews.last == this) {
      if (View.mouse0Down) {
        return CLICK_FILL;
      } else {
        return HOVER_FILL;
      }
    } else {
      return DEFAULT_FILL;
    }
  }

  String getForegroundColour() {
    if (gameView.currentContextView.getContextButton() == this) {
      return SELECTED_FOREGROUND;
    } else if (View.hoveredViews.last == this) {
      if (View.mouse0Down) {
        return CLICK_FOREGROUND;
      } else {
        return HOVER_FOREGROUND;
      }
    } else {
      return model.humanPlayer.color;
    }
  }

  @override
  void doMouseUp(MouseEvent e) {
    if(e.button == 0 && !e.ctrlKey) {
      gameView.switchContextView(contextView);
    }
  }
}
