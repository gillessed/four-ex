part of space_penguin;

abstract class View {

  static bool mouse0Down = false;
  static bool mouse1Down = false;
  static bool mouse2Down = false;

  static View keyFocusView;
  static List<View> mouseFocusViews = [];
  static Map<String, View> eventViews = {};
  static Map<String, List<Function>> globalEventListeners = {
    Event.MOUSE_WHEEL: [],
    Event.MOUSE_UP: [],
    Event.MOUSE_DOWN: [],
    Event.MOUSE_MOVED: [],
  };

  BiList<View, Placement> _children;
  Map<String, Function> eventListeners;
  Theme uiTheme;
  bool isVisible;
  bool clip;
  num width = 0;
  num height = 0;
  View parent;
  TPoint mouse;
  TPoint oldMouse;
  Style style;
  
  View({this.uiTheme, this.clip: false}) {
    style = new Style();
    _children = new BiList.blank();
    mouse = new TPoint.zero();
    oldMouse = new TPoint.zero();
    isVisible = true;
    eventListeners = {};
  }

  Theme get theme {
    if(uiTheme == null) {
      if(parent == null) {
        return new Theme.single('rgb(0,0,0)');
      } else {
        return parent.theme;
      }
    } else {
      return uiTheme;
    }
  }

  bool get mouseHover => View.mouseFocusViews.contains(this);
  
  void draw(CanvasRenderingContext2D context) {
    if(clip) {
      context.save();
      pathBorder(context);
      context.clip();
    }
    context.save();
    drawComponent(context);
    context.restore();
    _children.forEach((child, placement) {
      if(child.isVisible) {
        context.save();
        placement.computeTranslation(width, height).apply(context);
        Dimension d = placement.computeDimensions(width, height);
        child.width = d.width;
        child.height = d.height;
        child.draw(context);
        context.restore();
      }
    });
    if(clip) {
      context.restore();
    }
  }

  bool consumesMouseEvent() {
    return eventListeners.containsKey(Event.MOUSE_DOWN)
      || eventListeners.containsKey(Event.MOUSE_UP)
      || eventListeners.containsKey(Event.MOUSE_MOVED)
      || eventListeners.containsKey(Event.MOUSE_WHEEL)
      || eventListeners.containsKey(Event.MOUSE_ENTERED)
      || eventListeners.containsKey(Event.MOUSE_EXITED);
  }
  
  bool computeHover() {
    if(containsPoint(mouse)) {
      if(computeChildHover()) {
        mouseFocusViews.insert(0, this);
        return true;
      } else if(consumesMouseEvent()) {
        mouseFocusViews.insert(0, this);
        return true;
      }
    }
    return false;
  }

  bool computeChildHover() {
    return _children.forEachReverseUntil((View child, Placement placement) {
      return child.computeHover();
    });
  }

  void computeMouseMoved(View child, Placement placement) {
    Translation translation = placement.computeTranslation(width, height);
    TPoint transformedPoint = translation.inverse().applyToPoint(mouse);
    child.oldMouse.x = child.mouse.x;
    child.oldMouse.y = child.mouse.y;
    child.mouse.x = transformedPoint.x;
    child.mouse.y = transformedPoint.y;
    child._children.forEach((subchild, subplacement) {
      child.computeMouseMoved(subchild, subplacement);
    });
  }

  void eventKeyUp(KeyboardEvent e) {
    if(keyFocusView != null && keyFocusView.eventListeners.containsKey(Event.KEY_UP)) {
      keyFocusView.eventListeners[Event.KEY_UP](e);
    }
  }
  
  void eventKeyDown(KeyboardEvent e) {
    if(keyFocusView != null && keyFocusView.eventListeners.containsKey(Event.KEY_DOWN)) {
      keyFocusView.eventListeners[Event.KEY_DOWN](e);
    }
  }
  
  void eventMouseWheel(WheelEvent e) {
    getViewForEvent(Event.MOUSE_WHEEL)(e);
    for(Function listener in View.globalEventListeners[Event.MOUSE_WHEEL]) {
      listener(e);
    }
  }
  
  void eventMouseDown(MouseEvent e) {
    getViewForEvent(Event.MOUSE_DOWN)(e);
    for(Function listener in View.globalEventListeners[Event.MOUSE_DOWN]) {
      listener(e);
    }
  }
  
  void eventMouseUp(MouseEvent e) {
    getViewForEvent(Event.MOUSE_UP)(e);
    for(Function listener in View.globalEventListeners[Event.MOUSE_UP]) {
      listener(e);
    }
    if(mouseFocusViews.isNotEmpty) {
      keyFocusView = mouseFocusViews.last;
    } else {
      keyFocusView = null;
    }
  }
  
  void eventMouseMoved(MouseEvent e, TPoint point) {
    mouse = new TPoint.fromPoint(point);
    _children.forEach((child, placement) {
      computeMouseMoved(child, placement);
    });
    getViewForEvent(Event.MOUSE_MOVED)(e);
    for(Function listener in View.globalEventListeners[Event.MOUSE_MOVED]) {
      listener(e);
    }
  }

  Function getViewForEvent(String event) {
    for(View view in View.mouseFocusViews.reversed) {
      if(view.eventListeners.containsKey(event)) {
        return view.eventListeners[event];
      }
    }
    return (_){};
  }
  
  void drawComponent(CanvasRenderingContext2D context) {}

  void pathBorder(CanvasRenderingContext2D context) {
    context..beginPath()
      ..moveTo(0, 0)
      ..lineTo(0, height)
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..closePath();
  }

  bool containsPoint(TPoint point) {
    return point.x > 0 && point.x < width && point.y > 0 && point.y < height;
  }

  void addChildAt(View child, Function translation, Function dimension) {
    addChild(child, new Placement(translation, dimension));
  }

  void addChild(View child, Placement placement) {
    child.parent = this;
    _children.add(child, placement);
  }
  
  void replaceChild(View child, View newChild) {
    child.parent = null;
    newChild.parent = this;
    _children.replaceSByS(child, newChild);
  }
  
  Placement getPlacement(View child) {
    return _children.getT(child);
  }
  
  clearChildren() {
    _children.forEach((View child, Placement placement) {
      child.parent = null;
    });
    _children.clear();
  }
}