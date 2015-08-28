part of transformation;

class TPoint {
  num x;
  num y;
  TPoint.zero() : x = 0.0, y = 0.0;
  TPoint(this.x, this.y);
  TPoint.fromPoint(TPoint p) : x = p.x, y = p.y;
  TPoint translate(num dx, num dy) {
    return new TPoint(x + dx, y + dy);
  }
  TPoint scale(num sx, num sy) {
    return new TPoint(x * sx, y * sy);
  }
  TPoint rotate(num theta) {
    return new TPoint(
        x * cos(theta) - y * sin(theta),
        y * cos(theta) + x * sin(theta));
  }
  bool within(num left, num top, num width, num height) {
    return x >= left && x <= left + width && y >= top && y <= top + height;
  }
  
  @override
  String toString() {
    return "TPoint[${x}, ${y}]";
  }

  num distanceTo(TPoint point) {
    num dx = x - point.x;
    num dy = y - point.y;
    return sqrt(dx * dx + dy * dy);
  }

  TPoint apply(Transformation transformation) {
    return transformation.applyToPoint(this);
  }
}