library editor;

import 'dart:html';
import '../game/model/model.dart';

part 'constant_editor.dart';

main() {
  new EditorMain(querySelector('div.main'), []).show();
}

class EditorMain {

  Element mainElement;
  List<Editor> editors;
  List<Element> editorButtons;
  Element editorDiv;

  EditorMain(this.mainElement, this.editors);

  void show() {
    for(Editor editor in editors) {
      ButtonElement button = new ButtonElement();
      button.className = 'btn btn-default';
      button.onClick.listen((_) => editor.show);
    }

  }
}

abstract class Editor {
  String name;

  Editor(this.name);

  void show(DivElement editor);
}