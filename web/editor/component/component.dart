library component;

import 'dart:html' show CanvasRenderingContext2D;
import '../../space_penguin/space_penguin.dart';
import '../schema/schema.dart';

part 'object_component.dart';
part 'free_string_component.dart';

abstract class Component<T extends Schema> {
  T schema;

  Component(this.schema);

  View show();

  int computeHeight();

  static Component createComponent(Schema schema) {
    if(schema is ObjectSchema) {
      return new ObjectComponent(schema);
    } else if(schema is StringSchema) {
      StringSchema stringSchema = schema;
      if(stringSchema.possibleValues.isEmpty) {
        return new FreeStringComponent(stringSchema);
      } else {
        throw new SchemaError('Cant do bounded strings yet.');
      }
    }
    throw new SchemaError('Unknown schema type ${schema}.');
  }
}