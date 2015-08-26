part of view;

class SpaceView extends View {
  Game model;
  SpaceContextView spaceContextView;
  Translation spaceTranslation;
  UniformScale spaceScale;
  bool mapDrag = false;
  Space space;
  
  SpaceView(this.model, this.spaceContextView) {
   space = model.space;
   spaceTranslation = new Translation(0, 0);
   spaceScale = new UniformScale(100);
  }
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    spaceScale.apply(context);
    spaceTranslation.apply(context);
    
    context.lineWidth = 1 / spaceScale.s;
    context.strokeStyle = 'rgb(50,50,50)';
    for(int i = 0; i <= space.width; i++) {
      context
        ..moveTo(0, i)
        ..lineTo(space.width, i)
        ..moveTo(i, 0)
        ..lineTo(i, space.height)
        ..stroke();
    }
    
    space.starSystems.forEach((starSystem) {
      double MAX_RADIUS = 0.2;
      
      context.save();
      context.translate(starSystem.x, starSystem.y);
      num radius = (starSystem.star.size / 100.0) * MAX_RADIUS;
      var star1grd = context.createRadialGradient(0, 0, 0.01 * radius, 0, 0, 0.99 * radius);
      star1grd.addColorStop(0, starSystem.star.gradient0);
      star1grd.addColorStop(1, starSystem.star.gradient1);
      context.fillStyle = star1grd;
      context.beginPath();
      context.arc(0, 0, radius, 0, 2 * 3.14159);
      context.fill();
      context.restore();
    });
  }
  
  num get biggestDiff => max(width / space.width, height / space.height);  
  num get smallestSide => min(width, height);  
  num get minScale => biggestDiff;
  num get maxScale => smallestSide;

  @override
  void doMouseWheel(WheelEvent e) {
    num oldScale = spaceScale.s;
    spaceScale.s *= pow(1.003, -e.deltaY);
    if(spaceScale.s > maxScale) {
      spaceScale.s = maxScale;
    } else if (spaceScale.s < minScale) {
      spaceScale.s = minScale;
    }
    double x1 = (mouse.x - spaceTranslation.dx) / oldScale;
    double y1 = (mouse.y - spaceTranslation.dy) / oldScale;
    num factor = (spaceScale.s / oldScale) * (1 - spaceScale.s / oldScale);
    spaceTranslation.dx += x1 * factor;
    spaceTranslation.dy += y1 * factor;
  }

  @override
  void doMouseDown(MouseEvent e) {
    if(e.button == 0 && e.ctrlKey) {
      mapDrag = true;
    }
  }

  @override
  void doMouseUp(MouseEvent e) {
    mapDrag = false;
    if(e.button == 0 && !e.ctrlKey) {
      // TODO: selection
    }
  }
  
  @override
  void doMouseMoved(MouseEvent e) {
    if(mapDrag == true) {
      double dx = (mouse.x - oldMouse.x) / spaceScale.s;
      double dy = (mouse.y - oldMouse.y) / spaceScale.s; 
      spaceTranslation.dx += dx;
      spaceTranslation.dy += dy;
    }
  }
}