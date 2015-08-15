part of model;

class Terminal {
  static const int STATE_MAIN = 0;
  static const int STATE_NEW = 0;
  
  List<Output> lines;
  MainModel main;
  int state;
  Terminal(this.main) {
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
        if(line == "new game") {
          main.newGame();
        } else {
          showHelp(line);
        }
        break;
    }
  }
  
  void showHelp(line) {
    lines.add(new Line("Did not recognize command \"${line}\""));
    lines.add(new Line("Possible commands are:"));
    lines.add(new Line("  new game"));
    lines.add(new Line("  load game"));
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