part of space_penguin;

class VerticalScrollView extends View {
  static final num SCROLL_BAR_WIDTH = 15;

  View objectView;
  Function objectViewHeight;
  InnerView innerView;
  VerticalScrollBar scrollBar;
  num get ratio => height / objectViewHeight();

  VerticalScrollView(this.objectView, this.objectViewHeight) {
    innerView = new InnerView(this, objectView, objectViewHeight);
    addChildAt(
      innerView,
      Translation.CONSTANT(1, 1),
      (num parentWidth, num parentHeight) {
        return new Dimension(parentWidth - SCROLL_BAR_WIDTH - 2, parentHeight - 2);
      }
    );
    scrollBar = new VerticalScrollBar(this);
    addChildAt(
        scrollBar,
        (num parentWidth, num parentHeight) {
          return new Translation(parentWidth - SCROLL_BAR_WIDTH, 0);
        },
        (num parentWidth, num parentHeight) {
          return new Dimension(SCROLL_BAR_WIDTH, parentHeight);
        }
    );
    listen.on(Event.MOUSE_WHEEL, (WheelEvent e) => scroll(e.deltaY / 2));
  }

  @override
  drawComponent(CanvasRenderingContext2D context) {
    context
      ..beginPath()
      ..rect(0, 0, width, height)
      ..lineWidth = 2
      ..strokeStyle = theme.color1
      ..stroke();
  }

  void scroll(num amount) {
    scrollBar.scroller.addTranslation(amount);
  }
}

class InnerView extends View {

  VerticalScrollView scrollView;
  Function objectViewHeight;

  InnerView(this.scrollView, View objectView, this.objectViewHeight) : super(clip: true) {
    addChildAt(
      objectView,
      computeTranslation,
      (num parentWidth, num parentHeight) {
        return new Dimension(parentWidth, objectViewHeight());
      }
    );
  }

  Translation computeTranslation(num parentWidth, num parentHeight) {
    if(scrollView.ratio >= 1) {
      return new Translation(1, 1);
    } else {
      num ratioHeight = scrollView.ratio * scrollView.height;
      if(ratioHeight < VerticalScroller.MIN_HEIGHT) {
        VerticalScroller scroller = scrollView.scrollBar.scroller;
        num y = scroller.y;
        num realHeight = scrollView.ratio * scrollView.height;
        return new Translation(1, -((VerticalScroller.MIN_HEIGHT - realHeight) * y / scroller.yMax + y) / scrollView.ratio);
      } else {
        return new Translation(1, -scrollView.scrollBar.scroller.y / scrollView.ratio);
      }
    }
  }
}

class VerticalScrollBar extends View {
  VerticalScrollView scrollView;
  VerticalScroller scroller;
  VerticalScrollBar(this.scrollView) {
    scroller = new VerticalScroller(scrollView);
    addChildAt(
      scroller,
      scroller.computeTranslation,
      scroller.computeDimension
    );
    listen.on(Event.MOUSE_DOWN, (MouseEvent e) {
      num mid = scroller.y + scroller.height / 2;
      scrollView.scroll(scrollView.mouse.y - mid);
      scroller.scrolling = true;
    });
  }

  @override
  drawComponent(CanvasRenderingContext2D context) {
    if(mouseHover || scroller.scrolling) {
      context.fillStyle = 'rgb(50, 50, 50)';
    } else {
      context.fillStyle = 'rgb(0, 0, 0)';
    }
    context
      ..beginPath()
      ..rect(0, 0, width, height)
      ..lineWidth = 2
      ..fill()
      ..strokeStyle = theme.color1
      ..stroke();
  }
}

class VerticalScroller extends View {

  static final num MIN_HEIGHT = 50;

  num y = 0;
  num get yMax => scrollView.height - height;
  bool scrolling = false;

  VerticalScrollView scrollView;
  VerticalScroller(this.scrollView) {
    listen.on(Event.MOUSE_UP, (MouseEvent e) {
      scrolling = false;
    });
    listen.on(Event.MOUSE_MOVED, (MouseEvent e) {
      if(scrolling) {
        scrollView.scroll(scrollView.mouse.y - scrollView.oldMouse.y);
      }
    });
    listen.on(Event.MOUSE_DOWN, (WheelEvent e) => scrolling = true);
  }

  @override
  drawComponent(CanvasRenderingContext2D context) {
    if(scrolling) {
      context.fillStyle = theme.color3;
    } else {
      context.fillStyle = theme.color2;
    }
    context
      ..beginPath()
      ..rect(0, 0, width, height)
      ..fill();
  }

  void addTranslation(num dy) {
    if(y + dy > yMax) {
      y = yMax;
    } else if(y + dy < 0) {
      y = 0;
    } else {
      y += dy;
    }
  }

  Translation computeTranslation(num parentWidth, num parentHeight) {
    return new Translation(1, y);
  }

  Dimension computeDimension(num parentWidth, num parentHeight) {
    if(scrollView.ratio > 1) {
      return new Dimension(parentWidth - 2, parentHeight - 2);
    } else {
      num ratioHeight = scrollView.ratio * scrollView.height;
      if(ratioHeight < MIN_HEIGHT) {
        return new Dimension(parentWidth - 2, MIN_HEIGHT);
      } else {
        return new Dimension(parentWidth - 2, ratioHeight);
      }
    }
  }
}