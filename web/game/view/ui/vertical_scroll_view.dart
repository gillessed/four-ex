part of view;

class VerticalScrollView extends View {
  
  View child;
  
  VerticalScrollView(this.child) {
    children[child] = new Translation(0, 0);;
  }

  void setScroll(num amount) {
    children[child] = new Translation(0, amount);
  }

  void scrollWithin(num amount, num min, num max) {
    Translation translation = children[child];
    if(translation.dy + amount > max) {
      children[child] = translation.translate(0, max - translation.dy);
    } else if (translation.dy + amount < min) {
      children[child] = translation.translate(0, min - translation.dy);
    } else {
      children[child] = translation.translate(0, amount);
    }
  }
}