part of game_view;

/**
 * This view draws the main space view with the grid, stars,
 * planets and other space objects. It has it's own coordinate
 * system separate from the view hierarchy.
 */
class SpaceView extends View {
  static const num LIGHT_YEAR_RATIO = 100.0;
  static const num MIN_RADIUS = 20.0;
  
  Game model;
  SpaceContextView spaceContextView;
  Translation spaceTranslation;
  UniformScale spaceScale;
  bool mapDrag = false;
  Space space;
  SpaceObject hover;
  
  SpaceView(this.model, this.spaceContextView) {
    space = model.space;
    spaceTranslation = new Translation(0, 0);
    spaceScale = new UniformScale(LIGHT_YEAR_RATIO);
    eventListeners[Event.MOUSE_WHEEL] = onMouseWheel;
    eventListeners[Event.MOUSE_DOWN] = onMouseDown;
    eventListeners[Event.MOUSE_UP] = onMouseUp;
    eventListeners[Event.MOUSE_MOVED] = onMouseMoved;
    eventListeners[Event.MOUSE_EXITED] = onMouseExited;
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
        ..beginPath()
        ..moveTo(0, i)
        ..lineTo(space.width, i)
        ..moveTo(i, 0)
        ..lineTo(i, space.height)
        ..stroke();
    }
    
    // Draw star systems
    num fontSize = 0.6;
    if(fontSize * spaceScale.s > 25) {
      fontSize = 25 / spaceScale.s;
    }
    space.starSystems.forEach((starSystem) {
      num radius = (starSystem.star.size / LIGHT_YEAR_RATIO) * Star.MAX_RADIUS;
      num shadowBlur = 10 * spaceScale.s / LIGHT_YEAR_RATIO;
      context.save();
      context.translate(starSystem.pos.x, starSystem.pos.y);
      Icons.drawStar(context, starSystem, radius, shadowBlur);
      context.restore();
      context.save();
      context.translate(starSystem.pos.x, starSystem.pos.y);
      context
        ..fillStyle = starSystem.controlledStarSystem == null ? 'rgb(255,255,255)' : starSystem.controlledStarSystem.player.color.color1
        ..font = '${fontSize}px geo'
        // For some reason, without these lines, names won't render on a mac T_T
        ..shadowBlur = 0.00001
        ..shadowColor = 'rgb(255,255,255)'
        ..shadowOffsetX = 0
        ..shadowOffsetY = 0
        ..textAlign = 'center'
        ..fillText(starSystem.name, 0, fontSize + radius);
      context.restore();
    });
    
    if(hover != null && hover != spaceContextView.getSelectedObject()) {
      num radius = _getMinRadius(hover);
      context.save();
      context
        ..translate(hover.pos.x, hover.pos.y)
        ..strokeStyle = model.humanPlayer.color.color1
        ..setLineDash([5 / spaceScale.s])
        ..lineWidth = 2 / spaceScale.s
        ..beginPath()
        ..arc(0, 0, radius, 0, 2 * 3.14159)
        ..stroke();
      context.restore();
    }
    
    if(spaceContextView.getSelectedObject() != null) {
      SpaceObject object = spaceContextView.getSelectedObject();
      num radius = _getMinRadius(object);
      context.save();
      context
        ..translate(object.pos.x, object.pos.y)
        ..strokeStyle = 'rgb(255,255,255)'
        ..lineWidth = 2 / spaceScale.s
        ..beginPath()
        ..arc(0, 0, radius, 0, 2 * 3.14159)
        ..stroke();
      context.restore();
    }
  }
  
  num _getMinRadius(SpaceObject object) {
    num newRadius = object.getBoundingRadius();
    if(newRadius * spaceScale.s < MIN_RADIUS) {
      newRadius = MIN_RADIUS / spaceScale.s;
    }
    return newRadius;
  }
  
  num get biggestDiff => max(width / space.width, height / space.height);  
  num get smallestSide => min(width, height);  
  num get minScale => biggestDiff;
  num get maxScale => smallestSide;
  
  /**
   * Offset the space translation by a fixed about.
   */
  void changeTranslation(num dx, num dy) {
    setTranslation(
        spaceTranslation.dx + dx,
        spaceTranslation.dy + dy);
  }
  
  void centerViewOn(num x, num y) {
    double mx = -spaceTranslation.dx + (width / 2) / spaceScale.s;
    double my = -spaceTranslation.dy + (height / 2) / spaceScale.s;
    changeTranslation(mx - x, my - y);
  }
  
  void centerViewOnPoint(TPoint point) {
    centerViewOn(point.x, point.y);
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

  void onMouseWheel(WheelEvent e) {
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
    changeTranslation(mouse.x * factor, mouse.y * factor);
  }

  void onMouseDown(MouseEvent e) {
    if(e.button == 0 && e.ctrlKey) {
      mapDrag = true;
    }
  }

  void onMouseUp(MouseEvent e) {
    mapDrag = false;
    if(e.button == 0 && !e.ctrlKey) {
      spaceContextView.setStatusView(hover);
    }
  }
  
  void onMouseMoved(MouseEvent e) {
    if(mapDrag == true) {
      double dx = (mouse.x - oldMouse.x) / spaceScale.s;
      double dy = (mouse.y - oldMouse.y) / spaceScale.s;
      changeTranslation(dx, dy);
    } else if(!e.ctrlKey) {
      TPoint spacePoint = mouse.apply(spaceScale.inverse()).apply(spaceTranslation.inverse());
      for(StarSystem system in space.starSystems) {
        num radius = _getMinRadius(system);
        hover = null;
        if(system.pos.distanceTo(spacePoint) < radius) {
          hover = system;
          break;
        }
      }
    }
  }
  
  void onMouseExited() {
    mapDrag = false;    
  }
}