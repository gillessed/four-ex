part of view;

class Input extends View {
  String value;
  InputListeners listen;

  Input() : super(clip: true){
    value = '';
    listen = new InputListeners();
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {

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