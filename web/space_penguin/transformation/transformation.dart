part of space_penguin;

abstract class Transformation {
  Transformation inverse();
  void apply(CanvasRenderingContext2D context);
  TPoint applyToPoint(TPoint point);
}