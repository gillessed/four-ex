part of game_view;

class ColonyTileView extends View {
  static const int HEXAGON_RADIUS = 60;
  static const int BONUS_INDICATOR_RADIUS = 8;
  static const num BONUS_RADIUS = -HEXAGON_RADIUS * 0.75 + BONUS_INDICATOR_RADIUS;
  static const num BONUS_SPREAD = 4;
  int population;

  Colony colony;
  HexagonalLattice lattice;
  ColonyTileView(this.colony) {
    lattice = new HexagonalLattice.empty(
        true, false, Planet.TILE_WIDTH, Planet.TILE_HEIGHT);
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..save()
      ..beginPath()
      ..moveTo(0, 0)
      ..lineTo(0, height)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..closePath()
      ..clip()
      ..translate(HEXAGON_RADIUS + 10,
          HexagonalLattice.getHexagonHeight(HEXAGON_RADIUS) * 2 + 10);
    context
      ..strokeStyle = 'rgb(50,50,50)'
      ..lineWidth = 1;
    lattice.points(HEXAGON_RADIUS).forEach((TPoint center) {
      context.save();
      context.translate(center.x, center.y);
      Polygon.getHexagon(HEXAGON_RADIUS).drawPath(context);
      context.stroke();
      context.restore();
    });

    context
      ..strokeStyle = colony.system.player.color.color2
      ..lineWidth = 2;
    colony.planet.tiles
        .nonEmptyPoints(HEXAGON_RADIUS)
        .forEach((TPoint center, Tile tile) {
      context.save();
      context.translate(center.x, center.y);
      Polygon.getHexagon(HEXAGON_RADIUS).drawPath(context);
      context.stroke();
      num bonusAngle = -PI / (BONUS_SPREAD * 2) * (tile.bonuses.length - 1);
      tile.bonuses.forEach((Bonus bonus) {
        num _tx = -sin(bonusAngle) * BONUS_RADIUS;
        num _ty = cos(bonusAngle) * BONUS_RADIUS;
        context.translate(_tx, _ty);
        context.save();
        switch (bonus.type) {
          case BonusType.INDUSTRY:
            context.fillStyle = 'rgb(255,153,1)';
            break;
          case BonusType.RESEARCH:
            context.fillStyle = 'rgb(43,9,204)';
            break;
          case BonusType.ECONOMY:
            context.fillStyle = 'rgb(10,240,24)';
            break;
          case BonusType.HAPPINESS:
            context.fillStyle = 'rgb(255,255,0)';
            break;
          case BonusType.INFLUENCE:
            context.fillStyle = 'rgb(102,0,102)';
            break;
          case BonusType.POPULATION_GROWTH:
            context.fillStyle = 'rgb(0,102,0)';
            break;
          case BonusType.POPULATION_MAX:
            context.fillStyle = 'rgb(255,255,255)';
            break;
        }
        context.beginPath();
        if (bonus.amount == BIG_BONUS) {
          Polygon.getTriangle(BONUS_INDICATOR_RADIUS).drawPath(context);
        } else if (bonus.amount == BIGGER_BONUS) {
          Polygon.getSquare(BONUS_INDICATOR_RADIUS * 0.8).drawPath(context);
        } else if (bonus.amount == BIGGEST_BONUS) {
          Polygon.getPentagon(BONUS_INDICATOR_RADIUS * 0.78).drawPath(context);
        } else {
          throw new StateError('Should not have bonus amount ${bonus.amount}');
        }
        context
          ..shadowBlur = 0
          ..shadowColor = context.fillStyle
          ..shadowOffsetX = 0
          ..shadowOffsetY = 0
          ..fill();
        context.restore();
        context.translate(-_tx, -_ty);
        bonusAngle += PI / BONUS_SPREAD;
      });
      context.restore();
    });

    context.restore();

    context
      ..strokeStyle = colony.system.player.color.color2
      ..lineWidth = 2
      ..beginPath()
      ..moveTo(0, 0)
      ..lineTo(0, height)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..closePath()
      ..stroke();
  }
}
