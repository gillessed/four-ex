part of space_penguin;

class Polygon {
  List<TPoint> points;
  Rectangle boundingBox;
  
  Polygon(List<TPoint> points) {
    this.points = [];
    this.points.addAll(points);
    num xMax = points.first.x;
    num xMin = points.first.x;
    num yMax = points.first.y;
    num yMin = points.first.y;
    this.points.forEach((point) {
      if(point.x > xMax) {
        xMax = point.x;
      }
      if(point.x < xMin) {
        xMin = point.x;
      }
      if(point.y > yMax) {
        yMax = point.y;
      }
      if(point.y < yMin) {
        yMin = point.y;
      }
    });
    boundingBox = new Rectangle(xMin - 1, yMin - 1, xMax - xMin + 2, yMax - yMin + 2);
  }
  
  void drawPath(CanvasRenderingContext2D canvas) {
    canvas.beginPath();
    canvas.moveTo(points.first.x, points.first.y);
    for(int i = 1; i < points.length; i++) {
      canvas.lineTo(points[i].x, points[i].y);
    }
    canvas.closePath();
  }

  bool contains(TPoint p) {
    List<Segment> segments = [];
    for(int i = 0; i < points.length - 1; i++) {
      segments.add(new Segment(points[i], points[i + 1]));
    }
    segments.add(new Segment(points.last, points.first));
    TPoint outside = new TPoint(boundingBox.left, boundingBox.top);
    Segment toPoint = new Segment(outside, p);
    int count = 0;
    segments.forEach((s) {
      if(s.intersects(toPoint)) {
        count++;
      }
    });
    return (count % 2) == 1;
  }
  
  static num _trH = sin(3.14159 / 6);
  static num _trS = sin(3.14159 / 3);
  static Polygon getTriangle(num radius) {
    num h = radius * _trH;
    num s = radius * _trS;
    return new Polygon([
      new TPoint(-s, h),
      new TPoint(s, h),
      new TPoint(0, -radius)]);
  }
  
//  static num _sqX = 1 / sqrt(2);
  static Polygon getSquare(num radius) {
//    num x = radius * _sqX;
    return new Polygon([
      new TPoint(-radius, -radius),
      new TPoint(-radius, radius),
      new TPoint(radius, radius),
      new TPoint(radius, -radius)]);
  }
  
  static num _pentH = sin(3 * 3.14159 / 5);
  static num _pentS = sin(3.14159 / 5);
  static num _pentX = sin(3.14159 / 10);
  static num _pentY = sin(2 * 3.14159 / 5);
  static Polygon getPentagon(num radius) {
    num h = radius * _pentH;
    num s = radius * _pentS;
    num x = 2 * s * _pentX;
    num y = 2 * s * _pentY;
    return new Polygon([
      new TPoint(-s, h),
      new TPoint(s, h),
      new TPoint(s + x, h - y),
      new TPoint(0, -radius),
      new TPoint(-s - x, h - y)]);
  }
  
  static num _hexY = sqrt(3) / 2;
  static Polygon getHexagon(num radius) {
    num y = radius * _hexY;
    return new Polygon([
      new TPoint(-radius, 0),
      new TPoint(-radius/2, y),
      new TPoint(radius/2, y),
      new TPoint(radius, 0),
      new TPoint(radius/2, -y),
      new TPoint(-radius/2, -y)]);
  }
}