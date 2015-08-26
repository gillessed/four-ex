part of view;

class SpaceContextButton extends ContextButton {

  SpaceContextButton(GameView gameView, ContextView contextView)
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
      ..save()
      ..beginPath()
      ..translate(ContextButton.SIZE / 2, ContextButton.SIZE / 2)
      ..arc(0, 0, ContextButton.SIZE / 2 - 5, 0, 2 * 3.14159)
      ..restore()
      ..stroke();

    context
      ..save()
      ..beginPath()
      ..translate(ContextButton.SIZE / 2, ContextButton.SIZE / 2)
      ..rotate(-3.14159 / 4)
      ..scale(4, 1)
      ..arc(0, 0, 3.5, 0, 2 * 3.14159)
      ..restore()
      ..stroke();

    context
      ..save()
      ..beginPath()
      ..translate(ContextButton.SIZE / 2, ContextButton.SIZE / 2)
      ..rotate(-3.14159 / 4)
      ..arc(0, 0, ContextButton.SIZE / 2 - 5, 3.14159, 2 * 3.14159)
      ..restore()
      ..fill()
      ..stroke();
  }
}
