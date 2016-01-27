library component;

import 'dart:html';
import '../schema/schema.dart';

part 'object_component.dart';
part 'free_string_component.dart';

abstract class Component<T extends Schema> {
  T schema;

  Component(this.schema);

  Element show();

  static Component createComponent(Schema schema) {
    if(schema is ObjectSchema) {
      return new ObjectComponent(schema as ObjectSchema);
    } else if(schema is StringSchema) {
      StringSchema stringSchema = schema as StringSchema;
      if(stringSchema.possibleValues.isEmpty) {
        return new FreeStringComponent(stringSchema);
      } else {
        throw new SchemaError('Cant do bounded strings yet.');
      }
    }
    throw new SchemaError('Unknown schema type ${schema}.');
  }

  DivElement createPanel(Element child) {
    DivElement panel = new DivElement();
    panel.style.border = '1px solid black';
    panel.children.add(child);
    return panel;
  }
}