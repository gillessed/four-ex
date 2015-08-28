library model;

import 'dart:math' show Random, Point;
import 'dart:async';
import '../rest/rest_controller.dart' show restController;
import '../transformation/transformation.dart';
import '../utils/utils.dart';

part 'game.dart';
part 'terminal.dart';
part 'main_model.dart';
part 'player.dart';
part 'space/space.dart';
part 'space/space_properties.dart';
part 'space/star_system.dart';
part 'space/star.dart';

Random random = new Random();