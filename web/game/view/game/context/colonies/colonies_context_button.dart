part of view;

class ColoniesContextButton extends ContextButton {
  static const num OFFSET = 4;

  ColoniesContextButton(Game model, GameView gameView, ContextView contextView)
    : super(model, gameView, contextView);

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..fillStyle = getFillColour()
      ..strokeStyle = model.humanPlayer.color
      ..lineWidth = 2;

    polygon.drawPath(context);
    context
      ..fill()
      ..stroke();

    num oneThird = ContextButton.SIZE / 3;
    num half = ContextButton.SIZE * 1 / 2;
    num twoThirds = ContextButton.SIZE * 2 / 3;

    context
      ..strokeStyle = getForegroundColour()
      ..save()
      ..beginPath()
      ..moveTo(OFFSET, ContextButton.SIZE - OFFSET)
      ..lineTo(OFFSET, twoThirds)
      ..lineTo(oneThird, twoThirds)
      ..moveTo(oneThird, ContextButton.SIZE - OFFSET)
      ..lineTo(oneThird, OFFSET)
      ..lineTo(twoThirds, OFFSET)
      ..lineTo(twoThirds, ContextButton.SIZE - OFFSET)
      ..moveTo(twoThirds, half)
      ..lineTo(ContextButton.SIZE - OFFSET, half)
      ..lineTo(ContextButton.SIZE - OFFSET, ContextButton.SIZE - OFFSET)
      ..restore()
      ..stroke();
  }
}