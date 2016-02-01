library editor;

import 'dart:html' hide Dimension;
import 'dart:convert';
import 'schema/schema.dart';
import 'component/component.dart';
import '../space_penguin/space_penguin.dart';

void main() {

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

  EditorView view = new EditorView([
    new Editor('Constants', schema)
  ]);
  space_penguin(view);
}

class EditorView extends View {

  List<Editor> editors;

  EditorView(this.editors) {
    Label label = new Label('Four Ex Editor');
    label.style
      ..background = 'rgb(255, 255, 255)'
      ..textColor = 'rgb(0, 0, 0)'
      ..fontFamily = 'geo'
      ..fontSize = 80
      ..textAlign = 'center'
      ..verticalAlign = 'middle';
    addChildAt(label,
      Translation.ZERO_F,
      (num parentWidth, num parentHeight) {
        return new Dimension(parentWidth, 150);
      }
    );

    Component component = Component.createComponent(editors[0].schema);
    addChildAt(
      component.show(),
      (num parentWidth, num parentHeight) {
        return new Translation(30, 150);
      },
      (num parentWidth, num parentHeight) {
        return new Dimension(parentWidth - 60, component.computeHeight());
      }
    );
  }

  @override
  drawComponent(CanvasRenderingContext2D context) {
    context
      ..fillStyle = 'rgb(255, 255, 255)'
      ..beginPath()
      ..rect(0, 0, width, height)
      ..fill();
  }

}

class Editor {
  String name;
  Schema schema;

  Editor(this.name, this.schema);

//  void show(DivElement container) {
//    container.children.clear();
//    Component component = Component.createComponent(schema);
//    Element element = component.show();
//    container.children.add(element);
//  }
}