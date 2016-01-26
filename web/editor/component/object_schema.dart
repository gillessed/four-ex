part of component;

class ObjectSchema extends Schema<Map> {
  Map<String, Schema> fields;
  Map<String, Schema> optionalFields;

  ObjectSchema.parse(var json) {
    Map map = json as Map;
    fields = {};
    optionalFields = {};
    for(String key in map.keys) {
      if(key.startsWith('__')) {
        continue;
      } else if(key.endsWith('?')) {
        optionalFields[key] = Schema.parse(map[key]);
      } else {
        fields[key] = Schema.parse(map[key]);
      }
    }
  }

  void loadValue(var obj) {
    if(!(obj is Map)) {
      throw new StateError('Object ${obj} is not a map.');
    }
    //Check is obj has all keys
    //load each value into each sub-schema.
  }
}