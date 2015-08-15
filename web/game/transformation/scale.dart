part of transformation;

class Scale extends Transformation {
  num sx;
  num sy;
  Scale(this.sx, this.sy);
  
  @override
  void apply(CanvasRenderingContext2D context) {
    context.scale(sx, sy);
  }

  @override
  TPoint applyToPoint(TPoint point) {
    return point.scale(sx, sy);
  }
}