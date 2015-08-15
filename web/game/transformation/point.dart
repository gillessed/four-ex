part of transformation;

class TPoint {
  num x;
  num y;
  TPoint.zero() : x = 0.0, y = 0.0;
  TPoint(this.x, this.y);
  TPoint.fromPoint(TPoint p) : x = p.x, y = p.y;
  TPoint translate(double dx, double dy) {
    return new TPoint(x + dx, y + dy);
  }
  TPoint scale(double sx, double sy) {
    return new TPoint(x * sx, y * sy);
  }
  TPoint rotate(double theta) {
    return new TPoint(
        x * cos(theta) - y * sin(theta),
        y * cos(theta) + x * sin(theta));
  }
}