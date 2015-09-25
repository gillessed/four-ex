library transformation;

import 'dart:html';
import 'dart:math';
import '../utils/utils.dart';

part 'composite_transformation.dart';
part 'translation.dart';
part 'scale.dart';
part 'rotation.dart';
part 'point.dart';
part 'polygon.dart';
part 'vector.dart';
part 'hexagonal_lattice.dart';
part 'adjustable_sigmoid.dart';

abstract class Transformation {
  Transformation inverse();
  void apply(CanvasRenderingContext2D context);
  TPoint applyToPoint(TPoint point);
}