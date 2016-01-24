part of view;

class DraggableView extends View {
  View parentView;
  View childView;
  num childWidth;
  num childHeight;
  bool mapDrag;
  Translation childTranslation;

  DraggableView(this.parentView, this.childView, this.childWidth, this.childHeight) {
    mapDrag = false;
    childTranslation = new Translation(0, 0);
  }

  void translateLayer(num dx, num dy) {
    num x = childTranslation.dx;
    if(childWidth > width) {
      x += dx;
      if (x + dx > 0) {
        x = 0;
      }
      if (childWidth > width && x + dx < -childWidth + width) {
        x = -childWidth + width;
      }
    }
    num y = childTranslation.dy + dy;
    if(childHeight > height) {
      y += dy;
      if (y + dy > 0) {
        y = 0;
      }
      if (childHeight > height && y + dy < -childHeight + height) {
        y = -childHeight + height;
      }
    }
    childTranslation = new Translation(x, y);
  }
}