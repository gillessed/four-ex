part of schema;

class ObjectSchema extends Schema {
  Map<String, Schema> fields;
  Map<String, Schema> optionalFields;

  ObjectSchema() {
    fields = {};
    optionalFields = {};
  }

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

  @override
  Schema clone() {
    ObjectSchema copy = new ObjectSchema();
    fields.forEach((String key, Schema schema) {
      copy.fields[key] = schema.clone();
    });
    optionalFields.forEach((String key, Schema schema) {
      copy.optionalFields[key] = schema.clone();
    });
    return copy;
  }

  @override
  void loadValue(var obj) {
    if(!(obj is Map)) {
      throw new SchemaError('Object ${obj} is not a map.');
    }
    Map map = obj as Map;
    for(String key in fields.keys) {
      if(!map.containsKey(key)) {
        throw new SchemaError('Map ${map} does not has the required key [${key}].');
      }
    }
    for(String key in map.keys) {
      if(!fields.containsKey(key) && !optionalFields.containsKey(key)) {
        throw new SchemaError('This schema does not has the key [${key}].');
      }
    }
    for(String key in fields.keys) {
      fields[key].loadValue(map[key]);
    }
    for(String key in optionalFields.keys) {
      if(fields.containsKey(key)) {
        optionalFields[key].loadValue(map[key]);
      }
    }
  }

  @override
  void doDelete() {
    for(Schema schema in fields.values) {
      schema.delete();
    }
    for(Schema schema in optionalFields.values) {
      schema.delete();
    }
  }

  @override
  bool hasValue() {
    for(Schema schema in fields.values) {
      if(!schema.hasValue()) {
        return false;
      }
    }
    return true;
  }
}