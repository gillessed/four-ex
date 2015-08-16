part of view;

class TurnButton extends View {
  
  static const num BEVEL_WIDTH = 150;
  static const num LOWER_BEVEL_WIDTH = BEVEL_WIDTH - 2 * DEPTH;
  static const num DEPTH = 10;
  static const num OFFSET = 5;
  static const num HEIGHT = HudBar.TITLE_BAR_HEIGHT + DEPTH - 2 * OFFSET;
  
  Game model;
  Polygon polygon;
  
  TurnButton(this.model) {
    polygon = new Polygon([
      new TPoint(-LOWER_BEVEL_WIDTH / 2 - HEIGHT, 0),
      new TPoint(LOWER_BEVEL_WIDTH / 2 + HEIGHT, 0),
      new TPoint(LOWER_BEVEL_WIDTH / 2, HEIGHT),
      new TPoint(-LOWER_BEVEL_WIDTH / 2, HEIGHT)
    ]);
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context..save();
    
    if(View.hoveredViews.last == this) {
      context.fillStyle = "rgb(50,50,50)";
    } else {
      context.fillStyle = "rgb(0,0,0)";
    }
    context..strokeStyle = HudBar.HUD_COLOUR
           ..lineWidth = 2;
    
    polygon.drawPath(context);
    context..fill()
           ..stroke();
   
    context..strokeStyle = "rgb(255,255,255)"
           ..textAlign = "center"
           ..font = "20px Geo"
           ..strokeText("Turn ${model.turn}", 0, HEIGHT / 2 + 5);
           
    context..restore();
  }
  
  bool containsPoint(TPoint p) {
    return polygon.contains(p);
  }
}