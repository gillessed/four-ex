part of game_view;

class MainMenuView extends View {
  static const int LINE_HEIGHT = 40;
  
  num height;
  MainModel model;
  VerticalScrollView2 scroller;
  MainView mainView;
  Terminal terminal;
  
  MainMenuView(this.model, this.mainView) {
    terminal = new Terminal(model, mainView);

    listen.on(Event.KEY_DOWN, onKeyDown);
    listen.on(Event.MOUSE_WHEEL, onMouseWheel);
  }
  
  @override
  void drawComponent(CanvasRenderingContext2D context) {
    this.height = height;
    context..save()..translate(0, LINE_HEIGHT);
    for(Output line in terminal.lines) {
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

  int get totalHeight => LINE_HEIGHT * (terminal.lines.length + 1);

  void onKeyDown(KeyboardEvent e) {
    int keyCode = e.keyCode;
    if(keyCode >= KeyCode.A && keyCode <= KeyCode.Z) {
      if(e.shiftKey) {
        terminal.lines.last.line.add(keyCode);
      } else {
        terminal.lines.last.line.add(new String.fromCharCode(keyCode).toLowerCase().codeUnitAt(0));
      }
    }
    if(keyCode >= KeyCode.ZERO && keyCode <= KeyCode.NINE && !e.shiftKey) {
      terminal.lines.last.line.add(keyCode);
    }
    if(keyCode == KeyCode.PERIOD) {
      terminal.lines.last.line.add(".".codeUnitAt(0));
    }
    if(keyCode == KeyCode.DASH) {
      terminal.lines.last.line.add("-".codeUnitAt(0));
    }
    if(keyCode == KeyCode.SPACE) {
      terminal.lines.last.line.add(" ".codeUnitAt(0));
    }
    if(keyCode == KeyCode.BACKSPACE && terminal.lines.last.line.isNotEmpty) {
      terminal.lines.last.line.removeLast();
    }
    if(keyCode == KeyCode.ENTER) {
      terminal.enter();
    }
    if(scroller != null) {
      scrollToBottom();
    }
  }

  void onMouseWheel(WheelEvent e) {
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