library model;

import 'dart:math' show Random, Point;
import 'dart:async';
import '../transformation/transformation.dart';
import '../utils/utils.dart';

part 'game.dart';
part 'main_model.dart';
part 'player.dart';
part 'bonus/bonus.dart';
part 'bonus/tile_bonuses.dart';
part 'space/space.dart';
part 'space/space_properties.dart';
part 'space/star_system/star_system.dart';
part 'space/star_system/star.dart';
part 'space/star_system/planet.dart';
part 'space/star_system/gas_giant.dart';
part 'space/star_system/asteroid_belt.dart';
part 'space/star_system/tile.dart';

Random random = new Random();