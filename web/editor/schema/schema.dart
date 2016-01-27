library schema;

part 'object_schema.dart';
part 'boolean_schema.dart';
part 'num_schema.dart';
part 'array_schema.dart';
part 'string_schema.dart';

abstract class Schema {

  static final String TYPE = '__TYPE__';
  static final String STRING = 'str';
  static final String OBJECT = 'obj';
  static final String BOOL = 'bool';
  static final String NUM = 'num';
  static final String ARRAY = 'array';

  void loadValue(var obj);
  Schema clone();
  void doDelete();
  bool hasValue();

  List<Function> onDelete = [];

  void delete() {
    doDelete();
    for(Function function in onDelete) {
      function();
    }
  }

  static Schema parse(Map obj) {
    if(!obj.containsKey(TYPE)) {
      throw new StateError('Object ${obj} has no ${TYPE} key.');
    }
    if(obj[TYPE] == OBJECT) {
      return new ObjectSchema.parse(obj);
    } else if(obj[TYPE] == STRING) {
      return new StringSchema.parse(obj);
    } else if(obj[TYPE] == BOOL) {
      return new BooleanSchema();
    } else if(obj[TYPE] == NUM) {
      return new NumSchema();
    } else if(obj[TYPE] == ARRAY) {
      return new ArraySchema.parse(obj);
    } else {
      throw new StateError('Object ${obj} type unknown: ${obj[TYPE]}.');
    }
  }
}

class SchemaError extends Error {
  String message;
  SchemaError(this.message);
}