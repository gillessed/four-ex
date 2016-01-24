part of game_view;

class ColonyImprovementsView extends View {
  Colony colony;
  ColonyTileView view;

  ColonyImprovementsView(this.colony) {
    SimpleText text = new SimpleText('Sample text for scrollbar.', 600);
    VerticalScrollView scrollView = new VerticalScrollView(text, text.computeHeight);
    addChildAt(
      scrollView,
      Translation.CONSTANT(10, 10),
      Dimension.CONSTANT(300, 500)
    );
  }
}

class SimpleText extends View {
  String text;
  int times;
  SimpleText(this.text, this.times);

  @override
  drawComponent(CanvasRenderingContext2D context) {
    context
      ..translate(width / 2, 30)
      ..fillStyle = 'rgb(255,255,255)'
      ..textAlign = 'center'
      ..textBaseline = 'middle'
      ..font = '20px geo';
    for(int i = 0; i < times; i++) {
      context
        ..translate(0, 30)
        ..fillText('${i}: ${text}', 0, 0);
    }
  }

  num computeHeight() {
    return (times + 3) * 30;
  }
}
