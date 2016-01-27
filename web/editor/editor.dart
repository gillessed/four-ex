library editor;

import 'dart:html';
import 'dart:convert';
import 'schema/schema.dart';
import 'component/component.dart';
import '../game/model/model.dart';

main() {

  String schemaString = '''
{
  "__TYPE__": "obj",
  "NON_PLANET_FREQUENCY": {
    "__TYPE__": "str"
  },
  "PLANET_COUNT_DISTRIBUTION": {
    "__TYPE__": "obj",
    "SOME_KEY": {
      "__TYPE__": "str"
    },
    "SOME_OTHER_KEY":  {
      "__TYPE__": "obj",
      "NESTED_KEY": {
        "__TYPE__": "str"
      }
    }
  },
  "DEFAULT_PLANET_POPULATION": {
    "__TYPE__": "str"
  },
  "OPTIONAL_KEY?": {
    "__TYPE__": "str"
  },
  "OPTIONAL_OBJECT?": {
    "__TYPE__": "obj",
    "NESTED_OPTIONAL?": {
      "__TYPE__": "str"
    }
  }
}
  ''';
  Map json = JSON.decode(schemaString);
  Schema schema = Schema.parse(json);

  new EditorMain(querySelector('div#main'), [
    new Editor('Constants', schema)
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

    editorDiv = new DivElement();
    editorDiv.id = 'editor-div';
    editorDiv.style.paddingLeft = '100px';
    editorDiv.style.paddingRight = '100px';
    editorDiv.style.paddingTop = '100px';

    UListElement dropdownMenu = new UListElement();
    dropdownMenu.classes = ['dropdown-menu'];
    dropdownMenu.setAttribute('aria-labelledby', button.id);
    for(Editor editor in editors) {
      LIElement li = new LIElement();
      AnchorElement link = new AnchorElement();
      link.setAttribute('href', '#');
      link.innerHtml = editor.name;
      link.onClick.listen((_) {editor.show(editorDiv);});
      li.children.add(link);
      dropdownMenu.children.add(li);
    }
    dropdown.children.add(dropdownMenu);

    mainElement.children.add(dropdown);
    mainElement.children.add(editorDiv);
  }
}

class Editor {
  String name;
  Schema schema;

  Editor(this.name, this.schema);

  void show(DivElement container) {
    container.children.clear();
    Component component = Component.createComponent(schema);
    Element element = component.show();
    container.children.add(element);
  }
}