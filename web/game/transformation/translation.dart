part of transformation;

class Translation extends Transformation {
  num dx;
  num dy;
  Translation(this.dx, this.dy);

  Translation translate(num x, num y) {
    return new Translation(dx + x, dy + y);
  }
  
  @override
  void apply(CanvasRenderingContext2D context) {
    context.translate(dx, dy);
  }

  @override
  TPoint applyToPoint(TPoint point) {
    return point.translate(dx, dy);
  }
}