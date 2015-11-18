part of view;

class TurnButton extends View {
  
  static const num BEVEL_WIDTH = 150;
  static const num LOWER_BEVEL_WIDTH = BEVEL_WIDTH - 2 * DEPTH;
  static const num DEPTH = 10;
  static const num OFFSET = 5;
  static const num HEIGHT = HudBar.HUD_BAR_HEIGHT + DEPTH - 2 * OFFSET;
  
  static const String DEFAULT_FILL = "rgb(0,0,0)";
  static const String HOVER_FILL = "rgb(50,50,50)";
  static const String CLICK_FILL = "rgb(255,255,255)";
  static const String DEFAULT_TEXT = "rgb(255,255,255)";
  static const String HOVER_TEXT = "rgb(255,255,255)";
  static const String CLICK_TEXT = "rgb(0,0,0)";
  
  static const String FONT = "24px Geo";
  
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
    String fillColour = DEFAULT_FILL;
    String textColour = DEFAULT_TEXT;
    if(View.hoveredViews.isNotEmpty && View.hoveredViews.last == this) {
      if(View.mouse0Down) {
        fillColour = CLICK_FILL;
        textColour = CLICK_TEXT;
      } else {
        fillColour = HOVER_FILL;
        textColour = HOVER_TEXT;
      }
    }
    context..fillStyle = fillColour
           ..strokeStyle = model.humanPlayer.color.color2
           ..lineWidth = 2;
    
    polygon.drawPath(context);
    context..fill()
           ..stroke();
   
    context..strokeStyle = textColour
           ..textAlign = "center"
           ..font = FONT
           ..strokeText("Turn ${model.turn}", 0, HEIGHT / 2 + 5);
           
    context..restore();
  }
  
  bool containsPoint(TPoint p) {
    return polygon.contains(p);
  }

  void doMouseUp(MouseEvent e) {
    model.turn++;
  }
}