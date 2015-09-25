part of view;

class StarSystemStatusView extends View {
  static const PLANETARY_BODY_VIEW_WIDTH = 150;
  Game game;
  StarSystem model;
  StarStatusComponent starStatusComponent;
  StarSystemStatusView(this.game, this.model, SpaceView spaceView) {
    starStatusComponent = new StarStatusComponent(game, model, spaceView);
    addChild(
      starStatusComponent,
      new Placement(
        Translation.ZERO_F,
        (parentWidth, parentHeight) {
          return new Dimension(parentHeight, parentHeight);
        }
      )
    );
    int index = 0;
    model.planetaryBodies.forEach((PlanetaryBody body) {
      PlanetaryBodyStatusComponent child;
      if(body is Planet) {
        child = new PlanetStatusComponent(body, game, spaceView);
      } else if(body is GasGiant) {
        child = new GasGiantStatusComponent(body, spaceView);
      } else if(body is AsteroidBelt) {
        child = new AsteroidBeltStatusComponent(body, spaceView);
      }
      
      if(child != null) {
        child.translation = index;
        addChild(
          child,
          new Placement(
            (parentWidth, parentHeight) {
              return new Translation(parentHeight + child.translation * PLANETARY_BODY_VIEW_WIDTH, 0);
            },
            (parentWidth, parentHeight) {
              return new Dimension(PLANETARY_BODY_VIEW_WIDTH, parentHeight);
            }
          )
        );
      }
      index++;
    });
  }
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..strokeStyle = game.humanPlayer.color.color1
      ..fillStyle = 'rgb(0,0,0)'
      ..lineWidth = 2;
    
    context
      ..beginPath()
      ..moveTo(0, 0)
      ..lineTo(0, height)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..closePath()
      ..fill()
      ..stroke();
  }
}

class StarStatusComponent extends View {
  static const num STAR_COMPONENT_RADIUS = 60;
  static const num FONT_SIZE = 30;
  static const num BLUR_RADIUS = 20;
  SpaceView spaceView;
  StarSystem model;
  Game game;
  StarStatusComponent(this.game, this.model, this.spaceView);
  
  num get radius => (model.star.size / 100) * STAR_COMPONENT_RADIUS;
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.translate(width / 2, height / 2);
    num radius = (model.star.size / 100) * STAR_COMPONENT_RADIUS;
    num shadowBlur = BLUR_RADIUS * model.star.size / 100;
    Icons.drawStar(context, model, radius, shadowBlur);
    context
      ..fillStyle = 'rgb(255,255,255)'
      ..font = '${FONT_SIZE}px geo'
      ..textBaseline = 'middle'
      ..textAlign = 'center'
      ..fillText(model.name, 0, -(height / 2 + radius) / 2);
  }
  
  @override
  void doMouseUp(MouseEvent e) {
    if(mouse.distanceTo(new TPoint(width / 2, height / 2)) < radius) {
      spaceView.centerViewOnPoint(model.pos);
    }
  }
}

class PlanetaryBodyStatusComponent extends View {
  int translation;
}

const num LARGE_FONT_SIZE = 20;
const num SMALL_FONT_SIZE = 16;

class PlanetStatusComponent extends PlanetaryBodyStatusComponent {
  static const num PLANET_RADIUS = 20;
  SpaceView spaceView;
  Planet model;
  Game game;
  PlanetStatusComponent(this.model, this.game, this.spaceView);
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.translate(width / 2, height / 2);
    if(model.colony == null) {
      context
        ..strokeStyle = 'rgb(255,255,255)'
        ..beginPath()
        ..arc(0, 0, PLANET_RADIUS, 0, 2 * 3.14159)
        ..stroke()
        ..fillStyle = 'rgb(255,255,255)'
        ..font = '${LARGE_FONT_SIZE}px geo'
        ..textBaseline = 'middle'
        ..textAlign = 'center'
        ..fillText(model.nameQuality, 0, -(LARGE_FONT_SIZE + SMALL_FONT_SIZE + PLANET_RADIUS + 10))
        ..font = '${SMALL_FONT_SIZE}px geo'
        ..fillStyle = 'rgb(178,178,178)'
        ..fillText(model.type, 0, -(SMALL_FONT_SIZE + PLANET_RADIUS + 10))
        ..fillText('Uninhabited', 0, LARGE_FONT_SIZE + PLANET_RADIUS);
    } else if(model.colony.system.player == game.humanPlayer) {
      context
        ..strokeStyle = model.colony.system.player.color.color1
        ..beginPath()
        ..arc(0, 0, PLANET_RADIUS, 0, 2 * 3.14159)
        ..stroke()
        ..fillStyle = 'rgb(255,255,255)'
        ..font = '${LARGE_FONT_SIZE}px geo'
        ..textBaseline = 'middle'
        ..textAlign = 'center'
        ..fillText(model.nameQuality, 0, -(LARGE_FONT_SIZE + SMALL_FONT_SIZE + PLANET_RADIUS + 10))
        ..font = '${SMALL_FONT_SIZE}px geo'
        ..fillStyle = 'rgb(178,178,178)'
        ..fillText(model.type, 0, -(SMALL_FONT_SIZE + PLANET_RADIUS + 10))
        ..fillStyle = 'rgb(255,255,255)'
        ..fillText('Pop: ${model.colony.getPopulationMil()} M', 0, LARGE_FONT_SIZE + PLANET_RADIUS);
        //TODO: add open colony button. Damn, probably have to split this into three separate classes.
    } else {
      context
        ..strokeStyle = model.colony.system.player.color.color1
        ..beginPath()
        ..arc(0, 0, PLANET_RADIUS, 0, 2 * 3.14159)
        ..stroke()
        ..fillStyle = 'rgb(255,255,255)'
        ..font = '${LARGE_FONT_SIZE}px geo'
        ..textBaseline = 'middle'
        ..textAlign = 'center'
        ..fillText(model.nameQuality, 0, -(LARGE_FONT_SIZE + SMALL_FONT_SIZE + PLANET_RADIUS + 10))
        ..font = '${SMALL_FONT_SIZE}px geo'
        ..fillStyle = 'rgb(178,178,178)'
        ..fillText(model.type, 0, -(SMALL_FONT_SIZE + PLANET_RADIUS + 10));
    }
  }
}

class GasGiantStatusComponent extends PlanetaryBodyStatusComponent {
  static const num GAS_GIANT_RADIUS = 25;
  SpaceView spaceView;
  GasGiant model;
  GasGiantStatusComponent(this.model, this.spaceView);
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.translate(width / 2, height / 2);
    Icons.drawRingedPlanetIcon(context, GAS_GIANT_RADIUS, 'rgb(255,255,255)', 'rgb(70,70,70)', 1, 5);

    context
      ..fillStyle = 'rgb(255,255,255)'
      ..font = '${LARGE_FONT_SIZE}px geo'
      ..textBaseline = 'middle'
      ..textAlign = 'center'
      ..fillText(model.name, 0, -(LARGE_FONT_SIZE + SMALL_FONT_SIZE + GAS_GIANT_RADIUS + 10))
      ..font = '${SMALL_FONT_SIZE}px geo'
      ..fillStyle = 'rgb(178,178,178)'
      ..fillText('Gas Giant', 0, -(SMALL_FONT_SIZE + GAS_GIANT_RADIUS + 10));
  }
}

class AsteroidBeltStatusComponent extends PlanetaryBodyStatusComponent {
  static const num ASTEROID_SPREAD_RADIUS = 25;
  SpaceView spaceView;
  AsteroidBelt model;
  AsteroidBeltStatusComponent(this.model, this.spaceView);
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.translate(width / 2, height / 2);

    context
      ..fillStyle = 'rgb(0,255,0)'
      ..font = '40px geo'
      ..textBaseline = 'middle'
      ..textAlign = 'center'
      ..fillText('TODO', 0, 0);
    
    context
      ..fillStyle = 'rgb(255,255,255)'
      ..font = '${LARGE_FONT_SIZE}px geo'
      ..textBaseline = 'middle'
      ..textAlign = 'center'
      ..fillText(model.name, 0, -(LARGE_FONT_SIZE + SMALL_FONT_SIZE + ASTEROID_SPREAD_RADIUS + 10))
      ..font = '${SMALL_FONT_SIZE}px geo'
      ..fillStyle = 'rgb(178,178,178)'
      ..fillText('Asteroid Belt', 0, -(SMALL_FONT_SIZE + ASTEROID_SPREAD_RADIUS + 10));
  }
}