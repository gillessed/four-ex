part of game_view;

class EconomyContextButton extends ContextButton {
  static const num OFFSET = 3;
  static const num RADIUS = ContextButton.SIZE / 2 - OFFSET;
  static const num INNER_RADIUS = RADIUS * 0.5;
  static const num TOP_WIDTH = ContextButton.SIZE * 0.2;
  static const num BOTTOM_WIDTH = ContextButton.SIZE * 0.7;

  EconomyContextButton(Game model, GameView gameView, ContextView contextView)
    : super(model, gameView, contextView);

  @override
  void drawComponent(CanvasRenderingContext2D context) {
    context
      ..fillStyle = getFillColour()
      ..strokeStyle = model.humanPlayer.color.color1
      ..lineWidth = 2;

    polygon.drawPath(context);
    context
      ..fill()
      ..stroke();

    context
      ..strokeStyle = getForegroundColour()
      ..save()
      ..beginPath()
      ..translate(ContextButton.SIZE / 2, ContextButton.SIZE / 2)
      ..arc(0, 0, RADIUS, 0, 2 * 3.14159)
      ..restore()
      ..stroke();

    context
      ..save()
      ..beginPath()
      ..translate(ContextButton.SIZE / 2 + INNER_RADIUS / 8, ContextButton.SIZE / 2)
      ..arc(0, 0, INNER_RADIUS, 3.14159 / 2 - 0.9, 3.14159 * 3 / 2 + 0.9)
      ..restore()
      ..stroke();

    context
      ..save()
      ..beginPath()
      ..translate(ContextButton.SIZE / 2 + INNER_RADIUS / 8, ContextButton.SIZE / 2)
      ..moveTo(-2, INNER_RADIUS + 3)
      ..lineTo(-2, -INNER_RADIUS - 3)
      ..moveTo(1, INNER_RADIUS + 3)
      ..lineTo(1, -INNER_RADIUS - 3)
      ..restore()
      ..stroke();
  }
}