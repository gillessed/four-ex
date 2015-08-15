part of transformation;

class Rotation extends Transformation {
  num theta;
  Rotation(this.theta);
  
  @override
  void apply(CanvasRenderingContext2D context) {
    context.rotate(theta);
  }

  @override
  TPoint applyToPoint(TPoint point) {
    return point.rotate(theta);
  }
}