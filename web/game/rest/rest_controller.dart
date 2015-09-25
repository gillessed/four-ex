library rest;

import 'dart:html';
import 'dart:async';
import 'dart:convert';

RestController restController = new RestController();

class RestController {
  
  static const String GET = 'GET';
  static const String POST = 'POST';
  static const String UPDATE = 'UPDATE';
  static const String DELETE = 'DELETE';
  
  String restUri;
  
  RestController() {
    Uri uri = Uri.parse(window.location.href);
    restUri = '${uri.scheme}://${uri.host}:${uri.port}/rest';
    print('REST Controller iniatialized with URL ${restUri}');
  }

  Future getTestJson() {
    return _perform(GET, '/test');
  }
  
  Future getStarTypesJson() {
    return _perform(GET, '/data/stars.json');
  }
  
  Future getStarNamesJson() {
    return _perform(GET, '/data/star_names.json');
  }
  
  Future getPlanetsJson() {
    return _perform(GET, '/data/planets.json');
  }
  
  Future getConstantsJson() {
    return _perform(GET, '/data/constants.json');
  }
  
  Future getTechnologiesJson() {
    return _perform(GET, '/data/technologies.json');
  }
  
  Future _perform(String method, String route, {String sendDataArg}) {
    String sendData = sendDataArg;
    if(sendData == null) {
      sendData = '{}';
    }
    return HttpRequest.request(
        '${restUri}${route}',
        method: method,
        sendData: sendData).then((request) {
      return JSON.decode(request.responseText);
    });
  }
}