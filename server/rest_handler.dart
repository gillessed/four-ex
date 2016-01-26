part of server;

abstract class RestHandler {
  
  static RegExp VAR_REG_EXP = new RegExp(r'\[\[([^\]]+)\]\]');
  
  String restUri;
  RegExp restRegex;
  List<String> keys;
  
  RestHandler(this.restUri) {
    keys = [];
    var varMatches = VAR_REG_EXP.allMatches(restUri);
    varMatches.forEach((match) {
      keys.add(match[1]);
    });
    
    String regexString = restUri.replaceAll(new RegExp(r'\[\[[^\]]+\]\]'), '([^/]+)');
    restRegex = new RegExp(regexString);
  }
  
  static void sendServerError(HttpRequest request) {
    request.response.statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
    request.response.close();
  }
  
  static void sendNotFound(HttpRequest request) {
    request.response.statusCode = HttpStatus.NOT_FOUND;
    request.response.close();
  }
  
  static void sendBadRequest(HttpRequest request) {
    request.response.statusCode = HttpStatus.BAD_REQUEST;
    request.response.close();
  }
  
  static void sendForbiddenRequest(HttpRequest request) {
    request.response.statusCode = HttpStatus.FORBIDDEN;
    request.response.close();
  }
  
  static void sendError(HttpRequest request, String error) {
    request.response.statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
    request.response.write(error);
    request.response.close();
  }
  
  static void sendRedirect(HttpRequest request, String newUrl) {
    String host = request.headers.host;
    String port = request.headers.port.toString();
    request.response.headers.set("Refresh", '0; url=http://${host}:${port}/$newUrl');
    request.response.close();
  }

  bool assertDataHasKeys(Map<String, String> data, List<String> keys) {
    bool hasKeys = true;
    for(String key in keys) {
      if(!data.containsKey(key)) {
        hasKeys = false;
        break;
      }
    }
    return hasKeys;
  }
  
  Map<String, String> _parsePath(String path) {
    var restMatch = restRegex.firstMatch(path);
    Map<String, String> uriMap = {};
    for(int i = 1; i < restMatch.groupCount + 1; i++) {
      uriMap[keys[i - 1]] = restMatch[i];
    }
    return uriMap;
  }
  
  bool matchesPath(String path) {
    return restRegex.hasMatch(path);
  }
  
  void handleRequest(String path, HttpRequest request) {
    request.response.headers.set("Access-Control-Allow-Credentials", "true");
    try {
      if(request.method == 'POST' || request.method == 'UPDATE') {
        request.listen((List<int> buffer) {
          String bodyString = new String.fromCharCodes(buffer);
          Object body = JSON.decode(bodyString);
          handleDecodedRequest(path, request, body);
        }, cancelOnError: true);
      } else {
        handleDecodedRequest(path, request, {});
      }
    } catch (exception, stacktrace) {
      sendError(request, "Error processing request: [${exception} ${stacktrace}]");
    }
  }
  
  void handleDecodedRequest(String path, HttpRequest request, Object body) {
    Map<String, String> keys = _parsePath(path);
    Object responseBody;
    if(request.method == 'POST') {
      responseBody = handlePostRequest(path, keys, body);
    } else if(request.method == 'GET') {
      responseBody = handleGetRequest(path, keys, body);
    } else if(request.method == 'UPDATE') {
      responseBody = handleUpdateRequest(path, keys, body);
    } else if(request.method == 'DELETE') {
      responseBody = handleDeleteRequest(path, keys, body);
    } else {
      throw new StateError("Unknown method type ${request.method}.");
    }
    String responseString = JSON.encode(responseBody);
    request.response.headers.set(HttpHeaders.CONTENT_LENGTH, responseString.length.toString());
    request.response.headers.set(HttpHeaders.CONTENT_TYPE, 'application/json');
    request.response.statusCode = HttpStatus.OK;
    request.response.write(responseString);
    request.response.close();
  }
  
  Object handlePostRequest(String path, Map<String, String> keys, Object body) {
    throw new StateError("Cannot handle POST to ${path}.");
  }
  
  Object handleGetRequest(String path, Map<String, String> keys, Object body) {
    throw new StateError("Cannot handle GET to ${path}.");
  }
  
  Object handleUpdateRequest(String path, Map<String, String> keys, Object body) {
    throw new StateError("Cannot handle UPDATE to ${path}.");
  }
  
  Object handleDeleteRequest(String path, Map<String, String> keys, Object body) {
    throw new StateError("Cannot handle DELETE to ${path}.");
  }
}