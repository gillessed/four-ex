library transformation;

import "dart:html";
import "dart:math";

part 'composite_transformation.dart';
part 'translation.dart';
part 'scale.dart';
part 'rotation.dart';
part 'point.dart';
part 'polygon.dart';
part 'vector.dart';

abstract class Transformation {
  void apply(CanvasRenderingContext2D context);
  TPoint applyToPoint(TPoint point);
}