part of view;

class StarSystemStatusView extends View {
  static const PLANETARY_BODY_VIEW_WIDTH = 150;
  StarSystem model;
  StarStatusComponent starStatusComponent;
  StarSystemStatusView(this.model, SpaceView spaceView) {
    starStatusComponent = new StarStatusComponent(model, spaceView);
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
        child = new PlanetStatusComponent(body, spaceView);
      } else if(body is GasGiant) {
        child = new GasGiantStatusComponent(body, spaceView);
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
      ..strokeStyle = HudBar.HUD_COLOUR
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
  StarStatusComponent(this.model, this.spaceView);
  
  num get radius => (model.star.size / 100) * STAR_COMPONENT_RADIUS;
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.translate(width / 2, height / 2);
    num radius = (model.star.size / 100) * STAR_COMPONENT_RADIUS;
    var star1grd = context.createRadialGradient(0, 0, 0.01 * radius, 0, 0, 0.99 * radius);
    star1grd.addColorStop(0, model.star.gradient0);
    star1grd.addColorStop(1, model.star.gradient1);
    context
      ..fillStyle = star1grd
      ..beginPath()
      ..arc(0, 0, radius, 0, 2 * 3.14159)
      ..shadowColor = model.star.gradient1
      ..shadowBlur = BLUR_RADIUS * model.star.size / 100
      ..shadowOffsetX = 0
      ..shadowOffsetY = 0
      ..fill()
      ..fillStyle = 'rgb(255,255,255)'
      ..shadowBlur = 0.0001
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
  PlanetStatusComponent(this.model, this.spaceView);
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context.translate(width / 2, height / 2);
    context
      ..strokeStyle = 'rgb(255,255,255)'
      ..beginPath()
      ..arc(0, 0, PLANET_RADIUS, 0, 2 * 3.14159)
      ..stroke()
      ..fillStyle = 'rgb(255,255,255)'
      ..font = '${LARGE_FONT_SIZE}px geo'
      ..textBaseline = 'middle'
      ..textAlign = 'center'
      ..fillText(model.name, 0, -(LARGE_FONT_SIZE + SMALL_FONT_SIZE + PLANET_RADIUS + 10))
      ..font = '${SMALL_FONT_SIZE}px geo'
      ..fillStyle = 'rgb(178,178,178)'
      ..fillText(model.type, 0, -(SMALL_FONT_SIZE + PLANET_RADIUS + 10))
      ..fillText('Uninhabited', 0, LARGE_FONT_SIZE + PLANET_RADIUS);
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
//    context
//      ..strokeStyle = 'rgb(255,255,255)'
//      ..fillStyle = 'rgb(70,70,70)'
//      ..beginPath()
//      ..arc(0, 0, GAS_GIANT_RADIUS, 0, 2 * 3.14159)
//      ..fill()
//      ..stroke();
//
//    context
//      ..save()
//      ..lineWidth = 3
//      ..beginPath()
//      ..rotate(-3.14159 / 4)
//      ..scale(1.5, 0.5)
//      ..arc(0, 0, GAS_GIANT_RADIUS, 0, 2 * 3.14159)
//      ..stroke()
//      ..restore();
//
//    context
//      ..save()
//      ..beginPath()
//      ..rotate(-3.14159 / 4)
//      ..arc(0, 0, GAS_GIANT_RADIUS, 3.14159, 2 * 3.14159)
//      ..fill()
//      ..stroke()
//      ..restore();

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