part of view;

class DiplomacyContextButton extends ContextButton {
  static const num OFFSET = 6;
  static const num RADIUS = 2;

  DiplomacyContextButton(GameView gameView, ContextView contextView)
    : super(gameView, contextView);

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..fillStyle = getFillColour()
      ..strokeStyle = HudBar.HUD_COLOUR
      ..lineWidth = 2;

    polygon.drawPath(context);
    context
      ..fill()
      ..stroke();

    context
      ..strokeStyle = getForegroundColour()
      ..beginPath()
      ..moveTo(OFFSET, OFFSET)
      ..lineTo(ContextButton.SIZE - OFFSET, OFFSET)
      ..lineTo(ContextButton.SIZE - OFFSET, ContextButton.SIZE - OFFSET)
      ..lineTo(OFFSET, ContextButton.SIZE - OFFSET)
      ..lineTo(OFFSET, OFFSET)
      ..lineTo(ContextButton.SIZE - OFFSET, ContextButton.SIZE - OFFSET)
      ..moveTo(OFFSET, ContextButton.SIZE - OFFSET)
      ..lineTo(ContextButton.SIZE - OFFSET, OFFSET)
      ..stroke();

    _drawCircle(context, OFFSET, OFFSET);
    _drawCircle(context, ContextButton.SIZE - OFFSET, OFFSET);
    _drawCircle(context, OFFSET, ContextButton.SIZE - OFFSET);
    _drawCircle(context, ContextButton.SIZE - OFFSET, ContextButton.SIZE - OFFSET);
  }

  void _drawCircle(CanvasRenderingContext2D context, num x, num y) {
    context
      ..save()
      ..beginPath()
      ..translate(x, y)
      ..arc(0, 0, RADIUS, 0, 2 * 3.14159)
      ..restore()
      ..fill()
      ..stroke();
  }
}