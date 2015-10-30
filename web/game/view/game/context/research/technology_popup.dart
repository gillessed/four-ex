part of view;

enum Quadrant {
  TOP_LEFT,
  TOP_RIGHT,
  BOTTOM_LEFT,
  BOTTOM_RIGHT
}

class TechnologyPopup extends View {
  static const num WIDTH = 400;
  static const num HEIGHT = 400;
  static const num ARROW_WIDTH = 40;
  static const num ARROW_HEIGHT = 20;
  
  Player player;
  Technology technology;
  Quadrant mouseQuadrant = Quadrant.TOP_LEFT;
  TPoint bubblePoint;
  
  TechnologyPopup(this.player) : super(transparent: true){
    isVisible = false;
  }
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.translate(bubblePoint.x, bubblePoint.y);
    context.strokeStyle = player.color.color1;
    context.fillStyle = 'rgb(0,0,0)';
    switch(mouseQuadrant) {
      case Quadrant.TOP_LEFT:
        context
          ..beginPath()
          ..moveTo(0, 0)
          ..lineTo(ARROW_WIDTH + WIDTH, 0)
          ..lineTo(ARROW_WIDTH + WIDTH, HEIGHT)
          ..lineTo(ARROW_WIDTH, HEIGHT)
          ..lineTo(ARROW_WIDTH, ARROW_HEIGHT)
          ..closePath()
          ..fill()
          ..stroke()
          ..translate(ARROW_WIDTH, 0);
      break;
      case Quadrant.TOP_RIGHT:
        context
          ..beginPath()
          ..moveTo(0, 0)
          ..lineTo(-ARROW_WIDTH - WIDTH, 0)
          ..lineTo(-ARROW_WIDTH - WIDTH, HEIGHT)
          ..lineTo(-ARROW_WIDTH, HEIGHT)
          ..lineTo(-ARROW_WIDTH, ARROW_HEIGHT)
          ..closePath()
          ..fill()
          ..stroke()
          ..translate(-ARROW_WIDTH - WIDTH, 0);
      break;
      case Quadrant.BOTTOM_LEFT:
        context
          ..beginPath()
          ..moveTo(0, 0)
          ..lineTo(ARROW_WIDTH + WIDTH, 0)
          ..lineTo(ARROW_WIDTH + WIDTH, -HEIGHT)
          ..lineTo(ARROW_WIDTH, -HEIGHT)
          ..lineTo(ARROW_WIDTH, -ARROW_HEIGHT)
          ..closePath()
          ..fill()
          ..stroke()
          ..translate(ARROW_WIDTH, -HEIGHT);
      break;
      case Quadrant.BOTTOM_RIGHT:
        context
          ..beginPath()
          ..moveTo(0, 0)
          ..lineTo(-ARROW_WIDTH - WIDTH, 0)
          ..lineTo(-ARROW_WIDTH - WIDTH, -HEIGHT)
          ..lineTo(-ARROW_WIDTH, -HEIGHT)
          ..lineTo(-ARROW_WIDTH, -ARROW_HEIGHT)
          ..closePath()
          ..fill()
          ..stroke()
          ..translate(-ARROW_WIDTH - WIDTH, -HEIGHT);
      break;
    }
    
    context
      ..translate(WIDTH / 2, 35)
      ..fillStyle = 'rgb(255,255,255)'
      ..font = '30px geo'
      ..textAlign = 'center'
      ..fillText(technology.name, 0, 0);
  }
}