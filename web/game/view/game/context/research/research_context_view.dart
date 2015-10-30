part of view;

class ResearchContextView extends ContextView {
  static const num BUBBLE_WIDTH = 300;
  static const num BUBBLE_HEIGHT = 40;
  static const num BUBBLE_VERTICAL_DISTANCE = 20;
  static const num BUBBLE_HORIZONTAL_DISTANCE = 50;

  ResearchContextButton contextButton;
  GameView gameView;
  Map<Technology, TechnologyBubble> bubbleMap;
  TechnologyPopup technologyPopup;

  ResearchContextView(Game model, this.gameView) : super(model) {
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
    num dx = BUBBLE_WIDTH + BUBBLE_HORIZONTAL_DISTANCE;
    num dy = BUBBLE_HEIGHT + BUBBLE_VERTICAL_DISTANCE;
    while (techStack.isNotEmpty) {
      TechnologyTuple tuple = techStack.removeLast();
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

    bubbleMap.forEach((Technology technology, TechnologyBubble bubble) {
      technology.children.forEach((Technology child) {
        bubble.childrenBubbles.add(bubbleMap[child]);
        print(bubble.translation);
        print(bubbleMap[child].translation);
      });
      addChild(bubble, new Placement((num parentWidth, num parentHeight) {
        return bubble.translation;
      }, (num parentWidth, num parentHeight) {
        return new Dimension(BUBBLE_WIDTH, BUBBLE_HEIGHT);
      }));
    });
    
    technologyPopup = new TechnologyPopup(model.humanPlayer);
    addChild(technologyPopup, Placement.NO_OP);
  }

  @override
  ContextButton getContextButton() {
    return contextButton;
  }
  
  @override
  void doMouseMoved(MouseEvent e) {
    if(mouse.x < width / 2) {
      if(mouse.y < height / 2) {
        technologyPopup.mouseQuadrant = Quadrant.TOP_LEFT;
      } else {
        technologyPopup.mouseQuadrant = Quadrant.BOTTOM_LEFT;
      }
    } else {
      if(mouse.y < height / 2) {
        technologyPopup.mouseQuadrant = Quadrant.TOP_RIGHT;
      } else {
        technologyPopup.mouseQuadrant = Quadrant.BOTTOM_RIGHT;
      }
    }
  }
}

class TechnologyTuple {
  Technology technology;
  int depth;
  TechnologyTuple(this.technology, this.depth);
}
