part of view;

class HudBar extends View {
  
  static const String HUD_COLOUR = "rgb(0,0,256)";
  static const num TITLE_BAR_HEIGHT = 30;
  
  Polygon get polygon {
    return new Polygon([
      new TPoint(1, 1),
      new TPoint(width - 1, 1),
      new TPoint(width - 1, TITLE_BAR_HEIGHT),
      new TPoint(width / 2 + TurnButton.BEVEL_WIDTH / 2, TITLE_BAR_HEIGHT),
      new TPoint(width / 2 + TurnButton.BEVEL_WIDTH / 2 - TurnButton.DEPTH, TITLE_BAR_HEIGHT + TurnButton.DEPTH),
      new TPoint(width / 2 - TurnButton.BEVEL_WIDTH / 2 + TurnButton.DEPTH, TITLE_BAR_HEIGHT + TurnButton.DEPTH),
      new TPoint(width / 2 - TurnButton.BEVEL_WIDTH / 2, TITLE_BAR_HEIGHT),
      new TPoint(1, TITLE_BAR_HEIGHT)
    ]);
  }
  TurnButton turnButton;
  GameView parent;
  Game model;
  
  HudBar(this.model) {
    turnButton = new TurnButton(model);
    addChild(
      turnButton, 
      new Placement(
        (num parentWidth, num parentHeight) {
          return new Translation(parentWidth / 2, TurnButton.OFFSET);
        },
        (num parentWidth, num parentHeight) {
          return new Dimension(0, 0);
        }
      ));
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.save();
    context..strokeStyle = HUD_COLOUR
           ..lineWidth = 2;
    
    context..beginPath();
    polygon.drawPath(context);
    context..stroke();
     
    context.restore();
  }

  @override
  bool containsPoint(TPoint point) {
    return polygon.contains(point);
  }
}