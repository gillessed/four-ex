library theme;

class Theme {
  String color1;
  String color2;
  String color3;
  String color4;

  Theme(this.color1, this.color2, this.color3, this.color4);
  Theme.single(String color) {
    this.color1 = color;
    this.color2 = color;
    this.color3 = color;
    this.color4 = color;
  }
}