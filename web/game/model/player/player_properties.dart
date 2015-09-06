part of model;

class PlayerProperties {
  PlayerColorPalette playerColor;
  String speciesName;
  String leaderName;
  String homeSystemName;
  PlayerProperties(this.playerColor, this.speciesName, this.leaderName, this.homeSystemName);
}

class PlayerColorPalette {
  String color1;
  String color2;
  String color3;
  String color4;
  PlayerColorPalette(this.color1, this.color2, this.color3, this.color4);
  PlayerColorPalette.single(String color) {
    this.color1 = color;
    this.color2 = color;
    this.color3 = color;
    this.color4 = color;
  }
}