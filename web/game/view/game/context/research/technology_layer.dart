part of view;

class TechnologyLayer extends View {
  Game game;
  Map<Technology, TechnologyBubble> bubbleMap;

  TechnologyLayer(this.game, this.bubbleMap) {
    isTransparent = true;
    bubbleMap.forEach((Technology technology, TechnologyBubble bubble) {
      technology.children.forEach((Technology child) {
        bubble.childrenBubbles.add(bubbleMap[child]);
      });
      addChild(bubble, new Placement((num parentWidth, num parentHeight) {
        return bubble.translation;
      }, (num parentWidth, num parentHeight) {
        return new Dimension(ResearchContextView.BUBBLE_WIDTH, ResearchContextView.BUBBLE_HEIGHT);
      }));
    });
  }
}