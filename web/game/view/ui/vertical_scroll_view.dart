part of view;

class VerticalScrollView extends View {
  
  Translation translation;
  View child;
  
  VerticalScrollView(this.child) {
    translation = new Translation(0, 0);
    addChild(
      child,
      new Placement(
        (num parentWidth, num parentHeight) {
          return translation;
        },
        (num parentWidth, num parentHeight) {
          return new Dimension(parentWidth, parentHeight);
    }));
  }

  void setScroll(num amount) {
    translation = new Translation(0, amount);
  }

  void scrollWithin(num amount, num min, num max) {
    if(translation.dy + amount > max) {
      translation = translation.translate(0, max - translation.dy);
    } else if (translation.dy + amount < min) {
      translation = translation.translate(0, min - translation.dy);
    } else {
      translation = translation.translate(0, amount);
    }
  }

  @override
  bool containsPoint(TPoint point) {
    return point.within(0, 0, width, height);
  }
}