part of space_penguin;

class TitleView extends View {
  String title;
  View childView;
  int fontSize;
  int margin;
  String colour;
  TitleView(this.title, this.childView,
      {this.fontSize: 20, this.colour: 'rgb(255, 255, 255)', this.margin: 5}) {
    addChildAt(
      childView,
      Translation.CONSTANT(0, fontSize + 2 * margin),
      (num parentWidth, num parentHeight) {
        return new Dimension(parentWidth, parentHeight - fontSize - 2 * margin);
      }
    );
  }

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..translate(20, fontSize / 2 + 5)
      ..font = '${fontSize}px geo'
      ..fillStyle = colour
      ..textAlign = 'left'
      ..textBaseline = 'middle'
      ..fillText(title, 0, 0);
  }
}