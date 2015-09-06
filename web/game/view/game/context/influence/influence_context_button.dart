part of view;

class InfluenceContextButton extends ContextButton {

  InfluenceContextButton(Game model, GameView gameView, ContextView contextView)
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

    num size = ContextButton.SIZE;

    context
      ..strokeStyle = getForegroundColour()
      ..beginPath()
      ..save()
      ..translate(size / 2, size / 2)
      ..scale(size * 0.9, size * 0.9)
      ..moveTo(-0.4, -0.4)
      ..lineTo(-0.38, -0.2)
      ..lineTo(-0.41, 0.22)
      ..lineTo(-0.32, 0.31)
      ..lineTo(-0.1, 0.42)
      ..lineTo(0.37, 0.12)
      ..lineTo(0.3, -0.08)
      ..lineTo(0.02, -0.2)
      ..lineTo(0.08, -0.4)
      ..closePath()
      ..restore()
      ..stroke();
  }
}