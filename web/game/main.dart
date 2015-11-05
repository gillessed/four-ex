// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'canvas.dart';
import 'model/model.dart';
import 'view/view.dart';
import 'transformation/transformation.dart';

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
  body.onKeyUp.listen((e) {mainView.onKeyUp(e);});
  body.onKeyDown.listen((e) {mainView.onKeyDown(e);});
  body.onMouseWheel.listen((e) {
    e.preventDefault();
    mainView.onMouseWheel(e);
  });
  body.onMouseMove.listen((e) {
    TPoint mouse = new TPoint(e.offset.x, e.offset.y);
    mainView.onMouseMoved(e, mouse);
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
    mainView.onMouseDown(e);
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
    mainView.onMouseUp(e);
  });
  Canvas canvas = new Canvas(canvasElement, (var context, num width, num height) {
    mainView.width = width;
    mainView.height = height;
    
    // Recreate hovered list
    List<View> oldViews = [];
    oldViews.addAll(View.hoveredViews);
    View.hoveredViews.clear();
    mainView.computeHover();
    
    // Do mouse entered/exited
    if(oldViews.isEmpty) {
      if(oldViews.isNotEmpty) {
        oldViews.last.doMouseEntered();
      }
    } else if(View.hoveredViews.isEmpty) {
      if(View.hoveredViews.isNotEmpty) {
        View.hoveredViews.last.doMouseEntered();
      }
    } else if(View.hoveredViews.last != oldViews.last) {
      oldViews.last.doMouseExited();
      View.hoveredViews.last.doMouseEntered();
    }

    // Draw
    mainView.draw(context);
  });
  canvas.start();
}