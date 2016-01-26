library component;

import 'dart:html';

part 'object_component.dart';
part 'object_schema.dart';

abstract class Component<T extends Schema> {
  T schema;

  Component(this.schema);

  void show(Element container);
}

abstract class Schema<T> {

  static final String TYPE = '__TYPE__';
  static final String STRING = 'str';
  static final String OBJECT = 'obj';
  static final String BOOL = 'bool';
  static final String NUM = 'num';
  static final String ARRAY = 'array';

  T value;

  void loadValue(var obj);

  static Schema parse(Map obj) {
    if(!obj.containsKey(TYPE)) {
      throw new StateError('Object ${obj} has no ${TYPE} key.');
    }
    if(obj[TYPE] == OBJECT) {
      return new ObjectSchema.parse(obj);
    } else {
      throw new StateError('Object ${obj} type unknown: ${obj[TYPE]}.');
    }
  }
}