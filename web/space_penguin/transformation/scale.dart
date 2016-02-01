part of space_penguin;

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

  @override
  Transformation inverse() {
    return new Scale(1 / sx, 1 / sy);
  }
}

class UniformScale extends Transformation {
  num s;
  UniformScale(this.s);
  
  @override
  void apply(CanvasRenderingContext2D context) {
    context.scale(s, s);
  }

  @override
  TPoint applyToPoint(TPoint point) {
    return point.scale(s, s);
  }

  @override
  Transformation inverse() {
    return new Scale(1 / s, 1 / s);
  }
}