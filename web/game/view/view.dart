library view;

import 'dart:html';
import 'dart:math';
import '../transformation/transformation.dart';
import '../model/model.dart';
import '../utils/utils.dart';

part 'placement.dart';
part 'menu/main_view.dart';
part 'menu/main_menu_view.dart';
part 'ui/vertical_scroll_view.dart';
part 'game/game_view.dart';
part 'game/hud/turn_button.dart';
part 'game/hud/context_button.dart';
part 'game/hud/hud_bar.dart';
part 'game/context/context_view.dart';
part 'game/context/space/space_context_view.dart';
part 'game/context/space/space_context_button.dart';
part 'game/context/space/space_view.dart';
part 'game/context/space/status_bar/status_bar_view.dart';
part 'game/context/influence/influence_context_view.dart';
part 'game/context/influence/influence_context_button.dart';
part 'game/context/colonies/colonies_context_view.dart';
part 'game/context/colonies/colonies_context_button.dart';
part 'game/context/research/research_context_view.dart';
part 'game/context/research/research_context_button.dart';
part 'game/context/economy/economy_context_view.dart';
part 'game/context/economy/economy_context_button.dart';
part 'game/context/diplomacy/diplomacy_context_view.dart';
part 'game/context/diplomacy/diplomacy_context_button.dart';

abstract class View {
  
  static bool mouse0Down = false;
  static bool mouse1Down = false;
  static bool mouse2Down = false;
  static View focusedView;
  static List<View> hoveredViews = [];
  
  BiList<View, Placement> _children;
  bool isVisible;
  num width = 0;
  num height = 0;
  View parent;
  TPoint mouse;
  TPoint oldMouse;
  
  View() {
    _children = new BiList.blank();
    mouse = new TPoint.zero();
    oldMouse = new TPoint.zero();
    isVisible = true;
  }
  
  void draw(CanvasRenderingContext2D context) {
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
  }
  
  void computeHover() {
    _children.forEachReverseUntil((child, placement) {
      if(child.isVisible) {
        return doComputeHover(child, placement);
      } else {
        return false;
      }
    });
  }

  bool doComputeHover(View child, Placement placement) {
    if(child.containsPoint(child.mouse)) {
      hoveredViews.add(child);
      child.computeHover();
      return true;
    } else {
      return false;
    }
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
  
  void onMouseDown(MouseEvent e) {
    if(hoveredViews.isNotEmpty) {
      hoveredViews.last.doMouseDown(e);
    }
  }
  
  void onMouseUp(MouseEvent e) {
    if(hoveredViews.isNotEmpty) {
      focusedView = hoveredViews.last;
      hoveredViews.last.doMouseUp(e);
    }
  }
  
  void onMouseMoved(MouseEvent e, TPoint point) {
    mouse = new TPoint.fromPoint(point);
    _children.forEach((child, placement) {
      computeMouseMoved(child, placement);
    });
    if(hoveredViews.isNotEmpty) {
      hoveredViews.last.doMouseMoved(e);
    }
  }
  
  void computeMouseMoved(View child, Placement placement) {
    Translation translation = placement.computeTranslation(width, height);
    TPoint tranformedPoint = translation.inverse().applyToPoint(mouse);
    child.oldMouse.x = child.mouse.x;
    child.oldMouse.y = child.mouse.y;
    child.mouse.x = tranformedPoint.x;
    child.mouse.y = tranformedPoint.y;
    child._children.forEach((subchild, subplacement) {
      child.computeMouseMoved(subchild, subplacement);
    });
  }

  void doKeyUp(KeyboardEvent e) {}
  void doKeyDown(KeyboardEvent e) {}
  void doMouseWheel(WheelEvent e) {}
  void doMouseDown(MouseEvent e) {}
  void doMouseUp(MouseEvent e) {}
  void doMouseMoved(MouseEvent e) {}
  
  void drawComponent(CanvasRenderingContext2D context) {}
  
  bool containsPoint(TPoint point) {
    return point.x > 0 && point.x < width && point.y > 0 && point.y < height;
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