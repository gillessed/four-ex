part of view;

class TurnButton {
  
  static const num BEVEL_WIDTH = 150;
  static const num LOWER_BEVEL_WIDTH = BEVEL_WIDTH - 2 * DEPTH;
  static const num DEPTH = 10;
  static const num OFFSET = 5;
  static const num HEIGHT = GameView.TITLE_BAR_HEIGHT + DEPTH - 2 * OFFSET;
  
  Game model;
  Polygon polygon;
  
  TurnButton(this.model) {
    List<TPoint> points = [];
    points.add(new TPoint(-LOWER_BEVEL_WIDTH / 2 - HEIGHT, 0));
    points.add(new TPoint(LOWER_BEVEL_WIDTH / 2 + HEIGHT, 0));
    points.add(new TPoint(LOWER_BEVEL_WIDTH / 2, HEIGHT));
    points.add(new TPoint(-LOWER_BEVEL_WIDTH / 2, HEIGHT));
    polygon = new Polygon(points);
  }
  
  void draw(CanvasRenderingContext2D context, double width, double height) {
    context..save();
    
    context..fillStyle = "rgb(0,0,0)"
           ..translate(width / 2, OFFSET);
    
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