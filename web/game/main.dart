// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'canvas.dart';
import 'transformation/transformation.dart';
import 'model/model.dart';
import 'view/view.dart';

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
    TPoint mousePoint = new TPoint(e.screenX, e.screenY);
    mainView.onMouseMoved(e, mousePoint);
  });
  Canvas canvas = new Canvas(canvasElement, (var context, int width, int height) {mainView.draw(context, width.toDouble(), height.toDouble());});
  canvas.start();
}