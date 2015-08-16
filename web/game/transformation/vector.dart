part of transformation;

num abs(num x) {
  if(x < 0) {
    return -x;
  } else {
    return x;
  }
}
  
class Segment {
  TPoint p1;
  TPoint p2;
  
  Segment(this.p1, this.p2);
  
  bool intersects(Segment other) {
    return crossesLine(other) && other.crossesLine(this);
  }
  
  bool crossesLine(Segment other) {
    Vector toP1 = new Vector.fromPoints(p1, other.p1);
    Vector toP2 = new Vector.fromPoints(p1, other.p2);
    Vector norm = new Vector.fromPoints(p1, p2).normal();
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

class Vector {
  num x;
  num y;
  
  Vector(this.x, this.y);
  
  Vector.fromPoints(TPoint p1, TPoint p2) {
    this.x = p2.x - p1.x;
    this.y = p2.y - p1.y;
  }
  
  num dot(Vector other) {
    return x * other.x + y * other.y;
  }
  
  Vector normal() {
    return new Vector(-y, x);
  }
}