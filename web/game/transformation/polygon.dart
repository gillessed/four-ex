part of transformation;

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
}