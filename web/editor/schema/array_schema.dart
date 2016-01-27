part of schema;

class ArraySchema extends Schema {

  static final String MODEL = '__MODEL__';
  static final String LENGTH = '__LENGTH__';

  List<Schema> value;
  int length;
  Schema arrayType;

  ArraySchema() {
    value = [];
    length = 0;
  }

  ArraySchema.parse(var json) {
    Map map = json as Map;
    value = [];
    length = 0;
    if(!map.containsKey(MODEL)) {
      throw new SchemaError('Array schema ${json} has no __MODEL__ key.');
    }
    if(!map[MODEL] is Map) {
      throw new SchemaError('Array schema __MODEL__ is not a map: ${map[MODEL]}');
    }
    arrayType = Schema.parse(map[MODEL] as Map);
    if(map.containsKey(LENGTH)) {
      length = int.parse(map[LENGTH] as String);
    }
  }

  @override
  void loadValue(var obj) {
    if(!obj is List) {
      throw new SchemaError('Object ${obj} is not an array.');
    }
    List list = obj as List;
    for(var item in list) {
      Schema clone = arrayType.clone();
      clone.loadValue(item);
      value.add(clone);
    }
  }

  @override
  Schema clone() {
    ArraySchema clone = new ArraySchema();
    clone.arrayType = arrayType.clone();
    return clone;
  }

  @override
  void doDelete() {
    for(Schema schema in value) {
      schema.delete();
    }
    value.clear();
  }

  @override
  bool hasValue() {
    if(value.isEmpty) {
       return false;
    }
    for(Schema schema in value) {
      if(!schema.hasValue()) {
        return false;
      }
    }
    return true;
  }
}