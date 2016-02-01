part of space_penguin;

class Translation extends Transformation {
  static Translation ZERO = new Translation(0, 0);
  static Function CONSTANT = (num x, num y) {
    return (a, b) {return new Translation(x, y);};
  };
  static Function PLUS = (num x, num y) {
    return (a, b) {return new Translation(a + x, b + y);};
  };
  static var ZERO_F = (num width, num height) {
    return ZERO;
  };
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

  @override
  Transformation inverse() {
    return new Translation(-dx, -dy);
  }
  
  @override
  String toString() {
    return 'Translation[x=${dx};y=${dy}]';
  }
}