library game;

import 'view/game_view.dart';
import 'model/model.dart';
import '../space_penguin/space_penguin.dart';

void main() {
  MainModel model = new MainModel();
  MainView mainView = new MainView(model);
  space_penguin(mainView);
}