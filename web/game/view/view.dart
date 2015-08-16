library view;

import 'dart:html';
import '../transformation/transformation.dart';
import '../model/model.dart';
import '../utils/utils.dart';

part 'placement.dart';
part 'game/hud/game_view.dart';
part 'game/hud/turn_button.dart';
part 'game/hud/hud_bar.dart';
part 'menu/main_view.dart';
part 'menu/main_menu_view.dart';
part 'ui/vertical_scroll_view.dart';

abstract class View {
  
  static View focusedView;
  static List<View> hoveredViews = [];
  static TPoint globalMouse = new TPoint(0, 0);
  
  BiList<View, Placement> _children;
  bool isVisible;
  num width = 0;
  num height = 0;
  View parent;
  TPoint mouse;
  
  View() {
    _children = new BiList.blank();
    mouse = new TPoint.zero();
    isVisible = true;
  }
  
  void draw(CanvasRenderingContext2D context) {
    if(parent == null) {
      mouse.x = View.globalMouse.x;
      mouse.y = View.globalMouse.y;
    }
    drawComponent(context);
    _children.forEachReverseUntil((child, placement) {
      if(child.isVisible) {
        return computeHover(child, placement);
      } else {
        return false;
      }
    });
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
  }

  void onKeyUp(KeyboardEvent e) {
    focusedView.doKeyUp(e);
  }
  
  void onKeyDown(KeyboardEvent e) {
    focusedView.doKeyDown(e);
  }
  
  void onMouseWheel(WheelEvent e) {
    focusedView.doMouseWheel(e);
  }
  
  void onMouseDown(WheelEvent e) {
    hoveredViews.last.doMouseDown(e);
  }
  
  void onMouseUp(WheelEvent e) {
    hoveredViews.last.doMouseUp(e);
  }

  bool computeHover(View child, Placement placement) {
    Translation translation = placement.computeTranslation(width, height);
    TPoint tranformedPoint = translation.inverse().applyToPoint(mouse);
    child.mouse.x = tranformedPoint.x;
    child.mouse.y = tranformedPoint.y;
    if(child.containsPoint(tranformedPoint)) {
      hoveredViews.add(child);
      return true;
    } else {
      return false;
    }
  }

  void doKeyUp(KeyboardEvent e) {}
  void doKeyDown(KeyboardEvent e) {}
  void doMouseWheel(WheelEvent e) {}
  void doMouseDown(WheelEvent e) {}
  void doMouseUp(WheelEvent e) {}
  
  void drawComponent(CanvasRenderingContext2D context) {}
  bool containsPoint(TPoint point);
  
  void addChild(View child, Placement placement) {
    child.parent = this;
    _children.add(child, placement);
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