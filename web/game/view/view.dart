library view;

import 'dart:html';
import 'dart:collection';
import '../transformation/transformation.dart';
import '../model/model.dart';

part 'placement.dart';
part 'game/game_view.dart';
part 'game/turn_button.dart';
part 'menu/main_view.dart';
part 'menu/main_menu_view.dart';
part 'ui/vertical_scroll_view.dart';

abstract class View {
  
  static View focusedView;
  
  LinkedHashMap<View, Translation> children;
  bool isVisible;
  
  View() {
    children = new LinkedHashMap();
    isVisible = true;
  }
  
  void draw(CanvasRenderingContext2D context, double width, double height) {
    drawComponent(context, width, height);
    children.forEach((child, transformation) {
      if(child.isVisible) {
        context.save();
        transformation.apply(context);
        child.draw(context, width, height);
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

  void onMouseMoved(MouseEvent e, Point mousePoint) {
    
  }

  void doKeyUp(KeyboardEvent e) {}
  void doKeyDown(KeyboardEvent e) {}
  void doMouseWheel(WheelEvent e) {}
  void doMouseMoved(MouseEvent e, Point mousePoint) {}
  
  void drawComponent(CanvasRenderingContext2D context, double width, double height) {}
}