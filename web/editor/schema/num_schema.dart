part of schema;

class NumSchema extends Schema {
  num value = 0;
  bool empty = true;

  @override
  void loadValue(var obj) {
    if(!(obj is num)) {
      throw new SchemaError('Json ${obj} is not a number.');
    }
    value = obj as num;
    empty = false;
  }

  @override
  Schema clone() {
    NumSchema clone = new NumSchema();
    clone.value = value;
    clone.empty = empty;
    return clone;
  }

  @override
  void doDelete() {
    empty = true;
  }

  @override
  bool hasValue() {
    return empty;
  }
}