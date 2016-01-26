part of server;

class RestServer {
  
  List<RestHandler> restHandlers;
  String basePath;

  RestServer(this.basePath) {
    restHandlers = [];
  }

  void register(RestHandler handler) {
    restHandlers.add(handler);
  }

  void start(String host, int port) {
    print('Starting server on port ${port}.');
    HttpServer.bind(host, port).then((server) {
      server.listen((HttpRequest request) {
        if (request.uri.path.startsWith("/rest")) {
          String restPath = request.uri.path.substring(5);
          RestHandler match;
          restHandlers.forEach((handler) {
            if (handler.matchesPath(restPath)) {
              if (match != null) {
                RestHandler.sendServerError(request);
              } else {
                match = handler;
              }
            }
          });
          if (match == null) {
            RestHandler.sendBadRequest(request);
          } else {
            match.handleRequest(restPath, request);
          }
        } else if (request.uri.path == '/') {
          _serveFile(request, '/html/index.html');
        } else {
          _serveFile(request, request.uri.path);
        }
      });
    });
  }

  void _serveFile(HttpRequest request, String path) {
    HttpResponse response = request.response;
    File file = new File('${basePath}/web${path}');
    print(file.path);
    print(file.existsSync());
    if (file.existsSync()) {
      if (path.endsWith('html')) {
        response.headers.set(HttpHeaders.CONTENT_TYPE, 'text/html');
      } else if (path.endsWith('dart')) {
        response.headers.set(HttpHeaders.CONTENT_TYPE, 'application/dart');
      } else if (path.endsWith('js')) {
        response.headers.set(HttpHeaders.CONTENT_TYPE, 'text/javascript');
      } else if (path.endsWith('css')) {
        response.headers.set(HttpHeaders.CONTENT_TYPE, 'text/css');
      } else if(path.endsWith('png')) {
        response.headers.set(HttpHeaders.CONTENT_TYPE, 'image/png');
      } else if(path.endsWith('ico')) {
        response.headers.set(HttpHeaders.CONTENT_TYPE, 'image/ico');
      } else if(path.endsWith('otf')) {
        response.headers.set(HttpHeaders.CONTENT_TYPE, 'font/opentype');
      }
      response.headers.set(HttpHeaders.CONTENT_LENGTH, file.lengthSync().toString());
      response.add(file.readAsBytesSync());
      response.close();
    } else {
      RestHandler.sendNotFound(request);
    }
  }
}
