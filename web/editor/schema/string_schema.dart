part of schema;

class StringSchema extends Schema {

  static final String VALUES = '__VALUES__';

  String value;
  List<String> possibleValues;

  StringSchema() {
    value = '';
    possibleValues = [];
  }

  StringSchema.parse(var json) {
    Map map = json as Map;
    value = '';
    possibleValues = [];
    if(map.containsKey(VALUES)) {
      possibleValues.addAll(map[VALUES]);
    }
  }

  @override
  void loadValue(var obj) {
    if(!obj is String) {
      throw new SchemaError('Object ${obj} is not a string.');
    }
    String str = obj as String;
    if(possibleValues.isNotEmpty && !possibleValues.contains(str)) {
      throw new SchemaError('String ${str} is not a possible value ${possibleValues}.');
    }
    value = str;
  }

  @override
  Schema clone() {
    StringSchema clone = new StringSchema();
    clone.value = value;
    clone.possibleValues = possibleValues;
    return clone;
  }

  @override
  void doDelete() {
    value = '';
  }

  @override
  bool hasValue() {
    return value.isNotEmpty;
  }
}