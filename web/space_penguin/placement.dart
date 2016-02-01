part of space_penguin;

class Placement {
  static Placement NO_OP = new Placement(Translation.ZERO_F, Dimension.NO_OP);
  var computeTranslation;
  var computeDimensions;
  Placement(this.computeTranslation, this.computeDimensions);
}

class Dimension {
  static Function NO_OP = (num width, num height) {
    return new Dimension(width, height);
  };
  static Function CONSTANT = (num width, num height) {
    return (a, b) {
      return new Dimension(width, height);
    };
  };
  static Function PLUS = (num width, num height) {
    return (a, b) {
      return new Dimension(a + width, b + height);
    };
  };
  num width;
  num height;
  Dimension(this.width, this.height);
}