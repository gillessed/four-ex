part of view;

class MinimapView extends View {
  Game model;
  Space space;
  SpaceContextView spaceContextView;
  SpaceView spaceView;
  UniformScale minimapScale;
  Rectangle minimapArea;
  num border;
  bool mapDrag;
  
  MinimapView(this.model, this.spaceContextView, this.spaceView) {
    space = model.space;
    minimapArea = new Rectangle(0, 0, 1, 1);
    mapDrag = false;
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
    
    // Draw star systems
    border = SpaceView.LIGHT_YEAR_RATIO / spaceView.minScale;
    minimapScale = new UniformScale(width / (max(space.width, space.height) + 2 * border));
    space.starSystems.forEach((starSystem) {
      context.save();
      minimapScale.apply(context);
      context
        ..beginPath()
        ..translate(border + starSystem.pos.x, border + starSystem.pos.y)
        ..fillStyle = 'rgb(200,200,200)'
        ..fillRect(0, 0, 1 / minimapScale.s, 1 / minimapScale.s)
        ..restore() 
        ..fill();
    });
    
    // Draw view rectangle
    context
      ..strokeStyle = 'rgb(255,0,0)'
      ..lineWidth = 1
      ..save();
    minimapScale.apply(context);
    context.translate(border, border);
    spaceView.spaceTranslation.inverse().apply(context);
    spaceView.spaceScale.inverse().apply(context);
    context
      ..beginPath()
      ..rect(0, 0, spaceView.width, spaceView.height)
      ..restore()
      ..stroke();
  }

  @override
  void doMouseDown(MouseEvent e) {
    displaceMap();
    mapDrag = true;
  }

  @override
  void doMouseUp(MouseEvent e) {
    mapDrag = false;
  }

  @override
  void doMouseMoved(MouseEvent e) {
    if(mapDrag) {
      displaceMap();
    }
  }

  @override
  void doMouseExited() {
    mapDrag = false;
  }
  
  void displaceMap() {
    double tx = mouse.x / width * (space.width + 2 * border) - border;
    double ty = mouse.y / height * (space.height + 2 * border) - border;
    double mx = -spaceView.spaceTranslation.dx + (spaceView.width / 2) / spaceView.spaceScale.s;
    double my = -spaceView.spaceTranslation.dy + (spaceView.height / 2) / spaceView.spaceScale.s;
    spaceView.changeTranslation(mx - tx, my - ty);
  }
  
}