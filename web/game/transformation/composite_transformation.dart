part of transformation;

class CompositeTransformation extends Transformation {
  List<Transformation> transformations;
  
  CompositeTransformation.blank() {
    transformations = [];
  }
  
  CompositeTransformation(this.transformations);

  void addTransformation(Transformation transformation) {
    transformations.add(transformation);
  }

  void reset() {
    transformations.clear();
  }

  void setTransformations(List<Transformation> transformations) {
    reset();
    this.transformations.addAll(transformations);
  }

  @override
  void apply(CanvasRenderingContext2D context) {
    for(Transformation transformation in transformations) {
      transformation.apply(context);
    }
  }

  @override
  Point applyToPoint(Point point) {
    Point value = point;
    for(Transformation transformation in transformations) {
      value = transformation.applyToPoint(value);
    }
    return value;
  }
}