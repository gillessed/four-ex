part of view;

class StarSystemStatusView extends View {
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
    
    context
      ..fillStyle = "rgb(100,100,100)"
      ..font = "50px Geo"
      ..textAlign = "center"
      ..fillText(model.name, width / 2, height / 2);
  }
}

class StarStatusComponent extends View {
  static const num STAR_COMPONENT_RADIUS = 60;
  static const num FONT_SIZE = 30;
  static const num BLUR_RADIUS = 20;
  SpaceView spaceView;
  StarSystem model;
  StarStatusComponent(this.model, this.spaceView);
  
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
}