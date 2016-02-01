part of space_penguin;

class Style {
  String background;
  String textColor;
  String fontFamily;
  int fontSize;
  String fontType;
  String borderColor;
  int borderThickness;
  String textAlign;
  String verticalAlign;
  int paddingLeft;
  int paddingRight;
  int paddingTop;
  int paddingBottom;
  void set padding(int value) {
    paddingLeft = paddingRight = paddingTop = paddingBottom = value;
  }

  Style hover;
  Style click;
}