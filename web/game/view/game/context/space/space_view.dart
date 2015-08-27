part of view;

/**
 * This view draws the main space view with the grid, stars,
 * planets and other space objects. It has it's own coordinate
 * system separate from the view hierarchy.
 */
class SpaceView extends View {
  static const num LIGHT_YEAR_RATIO = 100.0;
  
  Game model;
  SpaceContextView spaceContextView;
  Translation spaceTranslation;
  UniformScale spaceScale;
  bool mapDrag = false;
  Space space;
  
  SpaceView(this.model, this.spaceContextView) {
   space = model.space;
   spaceTranslation = new Translation(0, 0);
   spaceScale = new UniformScale(LIGHT_YEAR_RATIO);
  }
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    spaceScale.apply(context);
    spaceTranslation.apply(context);
    
    // Draw grid
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
    
    // Draw star systems
    space.starSystems.forEach((starSystem) {
      context.save();
      context.translate(starSystem.x, starSystem.y);
      num radius = (starSystem.star.size / LIGHT_YEAR_RATIO) * Star.MAX_RADIUS;
      var star1grd = context.createRadialGradient(0, 0, 0.01 * radius, 0, 0, 0.99 * radius);
      star1grd.addColorStop(0, starSystem.star.gradient0);
      star1grd.addColorStop(1, starSystem.star.gradient1);
      context
        ..fillStyle = star1grd
        ..beginPath()
        ..arc(0, 0, radius, 0, 2 * 3.14159)
        ..shadowColor = starSystem.star.gradient1
        ..shadowBlur = 10 * spaceScale.s / LIGHT_YEAR_RATIO
        ..shadowOffsetX = 0
        ..shadowOffsetY = 0
        ..fill()
        ..restore();
    });
  }
  
  num get biggestDiff => max(width / space.width, height / space.height);  
  num get smallestSide => min(width, height);  
  num get minScale => biggestDiff;
  num get maxScale => smallestSide;

  @override
  void doMouseWheel(WheelEvent e) {
    // Scale space view within bounds
    num oldScale = spaceScale.s;
    spaceScale.s *= pow(1.003, -e.deltaY);
    if(spaceScale.s > maxScale) {
      spaceScale.s = maxScale;
    } else if (spaceScale.s < minScale) {
      spaceScale.s = minScale;
    }
    
    // Translate space to keep mouse position static
    num factor = (1 / spaceScale.s - 1 / oldScale);
    changeTransformation(mouse.x * factor, mouse.y * factor);
  }
  
  /**
   * Offset the space translation by a fixed about.
   */
  void changeTransformation(num dx, num dy) {
    setTranslation(
        spaceTranslation.dx + dx,
        spaceTranslation.dy + dy);
  }
  
  void setTranslation(num dx, num dy) {
    if(dx > LIGHT_YEAR_RATIO / spaceScale.s) {
      dx = LIGHT_YEAR_RATIO / spaceScale.s;
    }
    if(dy > LIGHT_YEAR_RATIO / spaceScale.s) {
      dy = LIGHT_YEAR_RATIO / spaceScale.s;
    }
    double tx = width / spaceScale.s;
    if(dx < -space.width + tx - LIGHT_YEAR_RATIO / spaceScale.s) {
      dx = -space.width + tx - LIGHT_YEAR_RATIO / spaceScale.s;
    }
    double ty = height / spaceScale.s;
    if(dy < -space.height + ty - LIGHT_YEAR_RATIO / spaceScale.s) {
      dy = -space.height + ty - LIGHT_YEAR_RATIO / spaceScale.s;
    }
    spaceTranslation.dx = dx;
    spaceTranslation.dy = dy;
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
      changeTransformation(dx, dy);
    }
  }
  
  @override
  void doMouseExited() {
    mapDrag = false;    
  }
}