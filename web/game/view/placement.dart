part of view;

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
  num width;
  num height;
  Dimension(this.width, this.height);
}