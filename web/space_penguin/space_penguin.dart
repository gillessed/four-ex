library space_penguin;

import 'dart:html' hide Event;
import 'dart:math';
import 'dart:convert' show UTF8;
import 'theme.dart';
import 'canvas.dart';

part 'view.dart';
part 'placement.dart';
part 'components/style.dart';
part 'event.dart';
part 'components/scroll/vertical_scroll_view.dart';
part 'components/button/button.dart';
part 'components/selector/list_selector_view.dart';
part 'components/selector/index_list_selector.dart';
part 'components/paragraph.dart';
part 'components/tabbed_panel/tabbed_panel.dart';
part 'components/drag/draggable_view.dart';
part 'components/title/title_view.dart';
part 'components/label/label.dart';
part 'components/input/input.dart';
part 'components/input/key_map.dart';

part 'utils/bilist.dart';

part 'transformation/transformation.dart';
part 'transformation/composite_transformation.dart';
part 'transformation/translation.dart';
part 'transformation/scale.dart';
part 'transformation/rotation.dart';
part 'transformation/point.dart';
part 'transformation/polygon.dart';
part 'transformation/vector.dart';
part 'transformation/hexagonal_lattice.dart';
part 'transformation/adjustable_sigmoid.dart';

CanvasElement canvasElement;
ButtonElement createButton;
BodyElement body;
TextAreaElement textArea;

void space_penguin(View mainView) {
  document.onKeyDown.listen((e) {
    if(e.keyCode == KeyCode.BACKSPACE) {
      e.preventDefault();
    }
  });
  window.onScroll.listen((e) {
    e.preventDefault();
  });
  body = querySelector("body");
  body.onContextMenu.listen((e) {
    e.preventDefault();
    return false;
  });
  canvasElement = new CanvasElement(width: window.innerWidth, height: window.innerHeight);
  canvasElement.style.setProperty("position", "absolute");
  canvasElement.style.left = "0";
  canvasElement.style.top = "0";
  body.append(canvasElement);

  body.onKeyUp.listen((e) {mainView.eventKeyUp(e);});
  body.onKeyDown.listen((e) {mainView.eventKeyDown(e);});
  body.onMouseWheel.listen((e) {
    e.preventDefault();
    mainView.eventMouseWheel(e);
  });
  body.onMouseMove.listen((e) {
    TPoint mouse = new TPoint(e.offset.x, e.offset.y);
    mainView.eventMouseMoved(e, mouse);
  });
  body.onMouseDown.listen((e) {
    if(e.button == 0) {
      if(e.ctrlKey) {
        View.mouse1Down = true;
      } else { 
        View.mouse0Down = true;
      }
    } else if(e.button == 2) {
      View.mouse2Down = true;
    }
    mainView.eventMouseDown(e);
  });
  body.onMouseUp.listen((e) {
    if(e.button == 0) {
      if(e.ctrlKey) {
        View.mouse1Down = true;
      } else { 
        View.mouse0Down = false;
      }
    } else if(e.button == 2) {
      View.mouse2Down = false;
    }
    mainView.eventMouseUp(e);
  });
  Canvas canvas = new Canvas(canvasElement, (var context, num width, num height) {
    mainView.width = width;
    mainView.height = height;
    
    // Recreate hovered list
    List<View> oldViews = [];
    oldViews.addAll(View.mouseFocusViews);
    View.mouseFocusViews = [];
    mainView.computeHover();

    // Do mouse entered/exited
    for(View view in oldViews) {
      if(!View.mouseFocusViews.contains(view)) {
        view.listen.fire(Event.MOUSE_EXITED, null);
      }
    }
    for(View view in View.mouseFocusViews) {
      if(!oldViews.contains(view)) {
        view.listen.fire(Event.MOUSE_ENTERED, null);
      }
    }

    // Draw
    mainView.draw(context);
  });
  canvas.start();
}