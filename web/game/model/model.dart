library model;

import 'dart:math' show Point, max, min;
import '../transformation/transformation.dart';
import '../utils/utils.dart';
import '../view/theme.dart';

part 'game.dart';
part 'player/player.dart';
part 'player/player_properties.dart';
part 'bonus/bonus.dart';
part 'bonus/tile_bonuses.dart';
part 'colony/colony.dart';
part 'colony/improvement.dart';
part 'colony/orbital_platform.dart';
part 'space/space.dart';
part 'space/space_properties.dart';
part 'space/star_system/star_system.dart';
part 'space/star_system/star.dart';
part 'space/star_system/planet.dart';
part 'space/star_system/gas_giant.dart';
part 'space/star_system/asteroid_belt.dart';
part 'space/star_system/tile.dart';
part 'economy/economy.dart';
part 'research/technology.dart';
part 'research/research.dart';

class MainModel {
  Game game;
}