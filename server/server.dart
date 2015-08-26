library server;

import 'dart:io';
import 'dart:convert';

part 'rest_handler.dart';
part 'rest_server.dart';
part 'handlers/test_handler.dart';
part 'handlers/game_properties_handler.dart';

main() {
  String buildPath = new File(Platform.script.toFilePath()).parent.parent.path + "/build";
  String dataPath = new File(Platform.script.toFilePath()).parent.parent.path + "/data";
  
  RestServer server = new RestServer(buildPath);
  server.register(new TestHandler(dataPath));
  server.register(new GamePropertiesHandler(dataPath));
  server.start('localhost', 8803);
}
