// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html' hide Event;
import 'canvas.dart';
import 'model/model.dart';
import '../ui/view.dart';
import 'view/game_view.dart';
import '../ui/transformation/transformation.dart';

CanvasElement canvasElement;
ButtonElement createButton;
BodyElement body;
TextAreaElement textArea;

void main() {
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
  
  MainModel model = new MainModel();
  MainView mainView = new MainView(model);
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
      if(!View.mouseFocusViews.contains(view) && view.eventListeners.containsKey(Event.MOUSE_EXITED)) {
        view.eventListeners[Event.MOUSE_EXITED]();
      }
    }
    for(View view in View.mouseFocusViews) {
      if(!oldViews.contains(view) && view.eventListeners.containsKey(Event.MOUSE_ENTERED)) {
        view.eventListeners[Event.MOUSE_ENTERED]();
      }
    }

    // Draw
    mainView.draw(context);
  });
  canvas.start();
}