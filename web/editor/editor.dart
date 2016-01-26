library editor;

import 'dart:html';
import '../game/model/model.dart';

part 'constant_editor.dart';

main() {
  new EditorMain(querySelector('div#main'), [
    new ConstantEditor({})
  ]).show();
}

class EditorMain {

  Element mainElement;
  List<Editor> editors;
  Element editorDiv;

  EditorMain(this.mainElement, this.editors);

  void show() {
    DivElement dropdown = new DivElement();
    dropdown.classes = ['dropdown'];
    ButtonElement button = new ButtonElement();
    button.classes = ['btn', 'btn-default', 'dropdown-toggle'];
    button.id = 'editor-select-dropdown';
    button.setAttribute('data-toggle', 'dropdown');
    button.setAttribute('aria-haspopup', 'true');
    button.setAttribute('aria-expanded', 'true');
    button.innerHtml = 'Edit... <span class="caret"></span>';
    dropdown.children.add(button);

    UListElement dropdownMenu = new UListElement();
    dropdownMenu.classes = ['dropdown-menu'];
    dropdownMenu.setAttribute('aria-labelledby', button.id);
    for(Editor editor in editors) {
      LIElement li = new LIElement();
      AnchorElement link = new AnchorElement();
      link.setAttribute('href', '#');
      link.innerHtml = editor.name;
      link.onClick.listen((_) => editor.show);
      li.children.add(link);
      dropdownMenu.children.add(li);
    }
    dropdown.children.add(dropdownMenu);
    mainElement.children.add(dropdown);
  }
}

abstract class Editor {
  String name;

  Editor(this.name);

  void show(DivElement editor);
}