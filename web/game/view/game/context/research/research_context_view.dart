part of view;

class ResearchContextView extends ContextView {
  static const num BUBBLE_WIDTH = 300;
  static const num BUBBLE_HEIGHT = 40;
  static const num BUBBLE_VERTICAL_DISTANCE = 20;
  static const num BUBBLE_HORIZONTAL_DISTANCE = 50;

  ResearchContextButton contextButton;
  GameView gameView;
  Map<Technology, TechnologyBubble> bubbleMap;
  TechnologyLayer technologyLayer;
  TechnologyPopup technologyPopup;
  bool mapDrag;
  Translation layerTranslation;
  num layerWidth;
  num layerHeight;

  ResearchContextView(Game model, this.gameView) : super(model) {
    layerTranslation = new Translation(0, 0);
    mapDrag = false;
    contextButton = new ResearchContextButton(model, gameView, this);
    bubbleMap = {};
    List<TechnologyTuple> techStack = [];
    model.technologies.forEach((Technology technology) {
      if (technology.prerequisites.isEmpty) {
        techStack.insert(0, new TechnologyTuple(technology, 0));
      }
    });
    int height = 0;
    int previousDepth = -1;
    int greatestDepth = -1;
    num dx = BUBBLE_WIDTH + BUBBLE_HORIZONTAL_DISTANCE;
    num dy = BUBBLE_HEIGHT + BUBBLE_VERTICAL_DISTANCE;
    while (techStack.isNotEmpty) {
      TechnologyTuple tuple = techStack.removeLast();
      if(tuple.depth > greatestDepth) {
        greatestDepth = tuple.depth;
      }
      if (tuple.depth <= previousDepth) {
        height++;
      }
      Translation translation = new Translation(
          tuple.depth * dx + BUBBLE_WIDTH / 2, height * dy + BUBBLE_HEIGHT / 2);
      TechnologyBubble bubble = new TechnologyBubble(
          model.humanPlayer, this, tuple.technology, translation);
      bubbleMap[tuple.technology] = bubble;
      tuple.technology.children.reversed.forEach((Technology child) {
        techStack.add(new TechnologyTuple(child, tuple.depth + 1));
      });
      previousDepth = tuple.depth;
    }

    layerWidth = greatestDepth * dx + BUBBLE_WIDTH * 2;
    layerHeight = height * dy + BUBBLE_HEIGHT * 2;

    technologyLayer = new TechnologyLayer(model, bubbleMap);
    addChild(
      technologyLayer,
      new Placement(
          (num parentWidth, num parentHeight) {
            return layerTranslation;
          },
          (num parentWidth, num parentHeight) {
            return new Dimension(layerWidth, layerHeight);
          }
      )
    );

    technologyPopup = new TechnologyPopup(model.humanPlayer);
    addChild(technologyPopup, Placement.NO_OP);
  }

  @override
  ContextButton getContextButton() {
    return contextButton;
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
  }
  
  @override
  void doMouseMoved(MouseEvent e) {
    if(mapDrag) {
      num dx = mouse.x - oldMouse.x;
      num dy = mouse.y - oldMouse.y;
      translateLayer(dx, dy);
    } else {
      if (mouse.x < width / 2) {
        if (mouse.y < height / 2) {
          technologyPopup.mouseQuadrant = Quadrant.TOP_LEFT;
        } else {
          technologyPopup.mouseQuadrant = Quadrant.BOTTOM_LEFT;
        }
      } else {
        if (mouse.y < height / 2) {
          technologyPopup.mouseQuadrant = Quadrant.TOP_RIGHT;
        } else {
          technologyPopup.mouseQuadrant = Quadrant.BOTTOM_RIGHT;
        }
      }
    }
  }

  void translateLayer(num dx, num dy) {
    num x = layerTranslation.dx;
    if(layerWidth > width) {
      x += dx;
      if (x + dx > 0) {
        x = 0;
      }
      if (layerWidth > width && x + dx < -layerWidth + width) {
        x = -layerWidth + width;
      }
    }
    num y = layerTranslation.dy + dy;
    if(layerHeight > height) {
      y += dy;
      if (y + dy > 0) {
        y = 0;
      }
      if (layerHeight > height && y + dy < -layerHeight + height) {
        y = -layerHeight + height;
      }
    }
    layerTranslation = new Translation(x, y);
  }
}

class TechnologyTuple {
  Technology technology;
  int depth;
  TechnologyTuple(this.technology, this.depth);
}
