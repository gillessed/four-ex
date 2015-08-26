part of server;

class TestHandler extends RestHandler {
  
  String dataPath;
  
  TestHandler(this.dataPath) : super('^/test\$');

  @override
  Object handleGetRequest(String path, Map<String, String> keys, Object body) {
    String testJsonString = new File('data/test.json').readAsStringSync();
    return JSON.decode(testJsonString);
  }
}