part of server;

class GamePropertiesHandler extends RestHandler {
  static const String DATA_FILE = 'DATA_FILE';
  
  String dataPath;
  
  GamePropertiesHandler(this.dataPath) : super('^/data/[[${DATA_FILE}]]\$');

  @override
  Object handleGetRequest(String path, Map<String, String> keys, Object body) {
    String dataFile = keys[DATA_FILE];
    String testJsonString = new File('${dataPath}/${dataFile}').readAsStringSync();
    return JSON.decode(testJsonString);
  }
}