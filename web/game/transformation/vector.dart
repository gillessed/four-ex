part of transformation;

class Vector {
  TPoint p1;
  TPoint p2;
  
  Vector(this.p1, this.p2);
  
  num get dx => p2.x - p1.x;
  num get dy => p2.y - p1.y;
  
  num dot(Vector other) {
    return dx * other.dx + dy * other.dy;
  }
  
  Vector normal() {
    return new Vector(new Point(0, 0), new Point(-dy, dx));
  }
  
  num abs(num x) {
    if(x < 0) {
      return -x;
    } else {
      return x;
    }
  }
  
  bool intersects(Vector other) {
    Vector toP1 = new Vector(p1, other.p1);
    Vector toP2 = new Vector(p1, other.p1);
    Vector norm = normal();
    if(abs(toP1.dot(norm)) < -0.0001 || abs(toP2.dot(norm)) < 0.0001) {
      return true;
    }
    if(toP1.dot(norm) > 0 && toP2.dot(norm) < 0) {
      return true;
    }
    if(toP1.dot(norm) < 0 && toP2.dot(norm) > 0) {
      return true;
    }
    return false;
  }
}