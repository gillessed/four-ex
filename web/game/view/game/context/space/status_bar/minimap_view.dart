part of view;

class MinimapView extends View {
  Game model;
  Space space;
  SpaceContextView spaceContextView;
  UniformScale minimapScale;
  
  MinimapView(this.model, this.spaceContextView) {
    space = model.space;
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
    
//      context
//        ..translate(100, 100)
//        ..fillStyle = 'rgb(0,255,0)'
//        ..fillRect(0, 0, 5, 5)
//        ..restore()
//        ..fill();
    // Draw star systems
    minimapScale = new UniformScale(width / max(space.width, space.height));
    space.starSystems.forEach((starSystem) {
      context.save();
      minimapScale.apply(context);
      context
        ..beginPath()
        ..translate(starSystem.x, starSystem.y)
        ..fillStyle = 'rgb(200,200,200)'
        ..fillRect(0, 0, 1 / minimapScale.s, 1 / minimapScale.s)
        ..restore() 
        ..fill();
    });
  }
}