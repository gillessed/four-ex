part of game_view;

class Terminal {
  static const int STATE_MAIN = 0;
  static const int STATE_NEW = 0;
  
  List<Output> lines;
  MainModel main;
  MainView mainView;
  int state;
  Terminal(this.main, this.mainView) {
    lines = [new Prompt("")];
    state = STATE_MAIN;
  }

  void enter() {
    String line = new String.fromCharCodes(lines.last.line);
    parse(line.toLowerCase());
    lines.add(new Prompt(""));
  }
  
  void parse(String line) {
    switch(state) {
      case STATE_MAIN: 
        if(line == 'new game') {
          mainView.newGame();
        } else if(line == 'test rest') {
          restController.getTestJson().then(
            (json) {
              lines.add(new Line('REST endpoint is functioning'));
            }, onError: (error) {
              lines.add(new Line('REST endpoint is current down'));
            }
          );
        } else {
          showHelp(line);
        }
        break;
    }
  }
  
  void showHelp(line) {
    lines.add(new Line('Did not recognize command "${line}"'));
    lines.add(new Line('Possible commands are:'));
    lines.add(new Line('  new game'));
    lines.add(new Line('  load game'));
    lines.add(new Line('  test rest'));
  }
}

abstract class Output {
  bool isPrompt();
  List<int> line = [];
}

class Line extends Output {
  Line(String str) {
    this.line.addAll(str.codeUnits);
  }
  @override
  bool isPrompt() {
    return false;
  }
}

class Prompt extends Output {
  Prompt(String str) {
    this.line.addAll(str.codeUnits);
  }
  @override
  bool isPrompt() {
    return true;
  }
}