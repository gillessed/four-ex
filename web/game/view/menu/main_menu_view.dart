part of view;

class MainMenuView extends View {
  static const int LINE_HEIGHT = 40;
  
  num height;
  Terminal model;
  VerticalScrollView scroller;
  
  MainMenuView(this.model);
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    this.height = height;
    context..save()..translate(0, LINE_HEIGHT);
    for(Output line in model.lines) {
      String draw = new String.fromCharCodes(line.line);
      if(line.isPrompt()) {
        draw = "> " + draw;
      }
      context..font = "30px geo"
             ..fillStyle = "rgb(0,255,0)"
             ..fillText(draw, 25, 0)
             ..translate(0, LINE_HEIGHT);
    }
    context.restore();
  }

  void doKeyDown(KeyboardEvent e) {
    int keyCode = e.keyCode;
    if(keyCode >= KeyCode.A && keyCode <= KeyCode.Z) {
      if(e.shiftKey) {
        model.lines.last.line.add(keyCode);
      } else {
        model.lines.last.line.add(new String.fromCharCode(keyCode).toLowerCase().codeUnitAt(0));
      }
    }
    if(keyCode >= KeyCode.ZERO && keyCode <= KeyCode.NINE && !e.shiftKey) {
      model.lines.last.line.add(keyCode);
    }
    if(keyCode == KeyCode.PERIOD) {
      model.lines.last.line.add(".".codeUnitAt(0));
    }
    if(keyCode == KeyCode.DASH) {
      model.lines.last.line.add("-".codeUnitAt(0));
    }
    if(keyCode == KeyCode.SPACE) {
      model.lines.last.line.add(" ".codeUnitAt(0));
    }
    if(keyCode == KeyCode.BACKSPACE && model.lines.last.line.isNotEmpty) {
      model.lines.last.line.removeLast();
    }
    if(keyCode == KeyCode.ENTER) {
      model.enter();
    }
    if(scroller != null) {
      scrollToBottom();
    }
  }
  
  int get totalHeight => LINE_HEIGHT * (model.lines.length + 1);

  @override
  void doMouseWheel(WheelEvent e) {
    if(scroller != null && totalHeight > height) {
      scroller.scrollWithin(-e.deltaY, height - totalHeight, 0);
    }
  }

  void scrollToBottom() {
    if(totalHeight > height) {
      scroller.setScroll(height - totalHeight);
    }
  }

  @override
  bool containsPoint(TPoint point) {
    return true;
  }
}