part of view;

class ResearchContextButton extends ContextButton {
  static const num OFFSET = 4;
  static const num TOP_WIDTH = ContextButton.SIZE * 0.2;
  static const num BOTTOM_WIDTH = ContextButton.SIZE * 0.7;

  ResearchContextButton(Game model, GameView gameView, ContextView contextView)
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

    context
      ..strokeStyle = getForegroundColour()
      ..save()
      ..beginPath()
      ..moveTo(
          (ContextButton.SIZE - BOTTOM_WIDTH) / 2, ContextButton.SIZE - OFFSET)
      ..lineTo((ContextButton.SIZE - TOP_WIDTH) / 2, ContextButton.SIZE * 1 / 2)
      ..lineTo((ContextButton.SIZE - TOP_WIDTH) / 2, OFFSET)
      ..lineTo((ContextButton.SIZE + TOP_WIDTH) / 2, OFFSET)
      ..lineTo((ContextButton.SIZE + TOP_WIDTH) / 2, ContextButton.SIZE * 1 / 2)
      ..lineTo(
          (ContextButton.SIZE + BOTTOM_WIDTH) / 2, ContextButton.SIZE - OFFSET)
      ..closePath()
      ..restore()
      ..lineJoin = 'round'
      ..stroke();
  }
}