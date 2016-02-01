part of space_penguin;

class Input extends View {

  static final int OFFSET = 5;

  String _value;
  void set value(String str) {
    _value = str;
    textMeasurements?.clear();
  }
  String get value => _value;
  InputListeners listen;
  int cursorIndex;
  int highlightEnd;
  bool drag;
  List<num> textMeasurements;

  bool get focus => View.keyFocusView == this;
  bool get isCursor => cursorIndex == highlightEnd;

  Input() : super(clip: true) {
    style.fontSize = 16;
    style.fontFamily = 'arial';
    value = '';
    listen = new InputListeners();
    cursorIndex = 0;
    highlightEnd = 0;
    drag = false;
    textMeasurements = [];
    eventListeners[Event.MOUSE_DOWN] = (MouseEvent e) {
      View.keyFocusView = this;
      cursorIndex = getCursorPosition();
      highlightEnd = getCursorPosition();
      drag = true;
    };
    eventListeners[Event.MOUSE_MOVED] = (MouseEvent e) {
      if(drag) {
        highlightEnd = getCursorPosition();
      }
    };
    eventListeners[Event.MOUSE_UP] = (MouseEvent e) {
      drag = false;
    };
    eventListeners[Event.MOUSE_EXITED] = () {
      drag = false;
    };
    eventListeners[Event.KEY_DOWN] = (KeyEvent e) {
      if(e.ctrlKey) {
        if(e.keyCode == KeyCode.A) {
          cursorIndex = 0;
          highlightEnd = textMeasurements.length - 1;
        }
      } else {
        if(e.keyCode == KeyCode.LEFT) {
          if(isCursor) {
            if (cursorIndex > 0) {
              cursorIndex = highlightEnd = cursorIndex - 1;
            }
          } else {
            cursorIndex = highlightEnd = min(cursorIndex, highlightEnd);
          }
        } else if(e.keyCode == KeyCode.RIGHT) {
          if(isCursor) {
            if (cursorIndex < textMeasurements.length - 1) {
              cursorIndex = highlightEnd = cursorIndex + 1;
            }
          } else {
            cursorIndex = highlightEnd = max(cursorIndex, highlightEnd);
          }
        } else if(e.keyCode == KeyCode.BACKSPACE) {
          if(isCursor) {
            if (cursorIndex > 0) {
              value = value.substring(0, cursorIndex - 1) +
                  value.substring(cursorIndex);
              cursorIndex = highlightEnd = cursorIndex - 1;
            }
          } else {
            value = value.substring(0, min(cursorIndex, highlightEnd)) +
                value.substring(max(cursorIndex, highlightEnd));
            cursorIndex = highlightEnd = min(cursorIndex, highlightEnd);
          }
        } else if(e.keyCode == KeyCode.DELETE) {
          if(isCursor) {
            if (cursorIndex < textMeasurements.length - 1) {
              value = value.substring(0, cursorIndex) +
                  value.substring(cursorIndex + 1);
            }
          } else {
            value = value.substring(0, min(cursorIndex, highlightEnd)) +
                value.substring(max(cursorIndex, highlightEnd));
            cursorIndex = highlightEnd = min(cursorIndex, highlightEnd);
          }
        } else if(e.keyCode == KeyCode.HOME) {
          cursorIndex = highlightEnd = 0;
        } else if(e.keyCode == KeyCode.END) {
          cursorIndex = highlightEnd = textMeasurements.length - 1;
        } else if(KEY_MAP.containsKey(e.keyCode)) {
          String add;
          if(e.shiftKey && SHIFT_MAP.containsKey(e.keyCode)) {
            add = SHIFT_MAP[e.keyCode];
          } else {
            add = KEY_MAP[e.keyCode];
          }
          if(add != null) {
            value = value.substring(0, cursorIndex) + add + value.substring(cursorIndex);
            cursorIndex = highlightEnd = cursorIndex + 1;
          }
        }
      }
    };
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    if(textMeasurements.isEmpty && value.isNotEmpty) {
      computeMeasurements(context);
      if(cursorIndex > textMeasurements.length - 1) {
        cursorIndex = textMeasurements.length - 1;
      }
      highlightEnd = cursorIndex;
    } else if(textMeasurements.isEmpty && value.isEmpty){
      textMeasurements = [0];
      cursorIndex = highlightEnd = 0;
    }
    int thickness = style.borderThickness ?? 2;
    context
      ..fillStyle = style.background ?? 'rgb(255, 255, 255)'
      ..beginPath()
      ..rect(0, 0, width, height)
      ..fill();

    if(focus) {
      int focusWidth = 3;
      context
        ..lineWidth = focusWidth
        ..strokeStyle = 'rgba(0, 153, 255, 0.5)'
        ..beginPath()
        ..moveTo(thickness + focusWidth / 2, thickness + focusWidth / 2)
        ..lineTo(thickness / 2, height - thickness - focusWidth / 2)
        ..lineTo(width - thickness - focusWidth / 2, height - thickness - focusWidth / 2)
        ..lineTo(width - thickness - focusWidth / 2, thickness + focusWidth / 2)
        ..closePath()
        ..stroke();

      if(isCursor) {
        int cursorOffset = OFFSET + thickness;
        context
          ..lineWidth = 2
          ..strokeStyle = style.textColor
          ..beginPath()
          ..moveTo(cursorOffset + textMeasurements[cursorIndex],
              height / 2 - style.fontSize / 2)
          ..lineTo(cursorOffset + textMeasurements[cursorIndex],
              height / 2 + style.fontSize / 2)
          ..stroke();
      }
    }

    context
      ..lineWidth = thickness
      ..strokeStyle = style.borderColor ?? 'rgb(0, 0, 0)'
      ..beginPath()
      ..moveTo(thickness / 2, thickness / 2)
      ..lineTo(thickness / 2, height - thickness / 2)
      ..lineTo(width - thickness / 2, height - thickness / 2)
      ..lineTo(width - thickness / 2, thickness / 2)
      ..closePath()
      ..stroke();

    if(focus && !isCursor) {
      int start = min(cursorIndex, highlightEnd);
      int end = max(cursorIndex, highlightEnd);
      int cursorOffset = OFFSET + thickness;
      context
        ..fillStyle = 'rgb(115, 218, 252)'
        ..beginPath()
        ..moveTo(cursorOffset + textMeasurements[start], height / 2 - style.fontSize / 2)
        ..lineTo(cursorOffset + textMeasurements[end], height / 2 - style.fontSize / 2)
        ..lineTo(cursorOffset + textMeasurements[end], height / 2 + style.fontSize / 2)
        ..lineTo(cursorOffset + textMeasurements[start], height / 2 + style.fontSize / 2)
        ..closePath()
        ..fill();
    }

    context
      ..translate(thickness + OFFSET, height / 2)
      ..textAlign = 'left'
      ..textBaseline = 'middle'
      ..font = '${style.fontSize}px ${style.fontFamily}'
      ..fillStyle = style.textColor
      ..fillText(_value, style.paddingLeft ?? 0, 0);
  }

  int getCursorPosition() {
    num x = mouse.x - OFFSET - (style.borderThickness ?? 2);
    for(int i = 0; i < textMeasurements.length; i++) {
      if(textMeasurements[i] > x) {
        if(i == 0) {
          return 0;
        } else if((textMeasurements[i - 1] + textMeasurements[i]) / 2 > x){
          return i - 1;
        } else {
          return i;
        }
      }
    }
    return textMeasurements.length - 1;
  }

  void computeMeasurements(CanvasRenderingContext2D context) {
    context.font = '${style.fontSize}px ${style.fontFamily}';
    for(int i = 0; i <= _value.length; i++) {
      textMeasurements.add(context.measureText(_value.substring(0, i)).width);
    }
  }
}

class InputListeners {
  List<Function> _changeListeners;

  InputListeners() {
    _changeListeners = [];
  }

  onChange(Function function) {
    _changeListeners.add(function);
  }
}