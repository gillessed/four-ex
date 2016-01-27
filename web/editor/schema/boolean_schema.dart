part of schema;

class BooleanSchema extends Schema{
  bool value = false;

  @override
  void loadValue(var obj) {
    if(!(obj is bool)) {
      throw new SchemaError('Json ${obj} is not a bool.');
    }
    value = obj as bool;
  }

  @override
  Schema clone() {
    BooleanSchema clone = new BooleanSchema();
    clone.value = value;
    return clone;
  }

  @override
  void doDelete() {
    value = false;
  }

  @override
  bool hasValue() {
    return true;
  }
}